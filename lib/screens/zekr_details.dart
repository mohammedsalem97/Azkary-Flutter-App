import 'dart:math';

import 'package:azkar/models/user_model.dart';
import 'package:azkar/widgets/FAB.dart';
import 'package:azkar/widgets/background_shapes.dart';
import 'package:azkar/widgets/switch_theme_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'package:scoped_model/scoped_model.dart';

import 'azkar_categories_list.dart';
import 'favourites.dart';

import 'mesbaha.dart';

List<int> currentZekrCounts = [];

////tobeedited
///+++[1-how to add and remove from favList with notify the icon inside the FAB]
///+++[2-How to show that this has a description or not]
///+++[3-Add icon to change theme from here too]
///+++[4-change the radius of the cards]
///+++[5-solve the problem of alertdailog when longpressing on the Zekr to show description]
///+++[6-Remove the Scroll controllers]
///+++[7-use SharedPreferences to keep the font as it was left before opening the app]
///<--->[8-InkWell used in wa3y app Look at them]***
///+++[9-Longpress on the zekr to share it to platform share means]
///<---->[10-Friday Quran notifications]
///+++[11- Flip the small counter when the zekr counter is completed]

class ZekrList extends StatefulWidget {
  final String category;

  ZekrList({this.category});

  @override
  State<StatefulWidget> createState() {
    return _ZekrListState();
  }
}

class _ZekrListState extends State<ZekrList> {
  final List<Map<String, String>> mappedData = mappedJson;
  List<Map<String, String>> finalmappedData = [];
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isFavourite = false;
  @override
  void initState() {
    for (int c = 0; c < mappedData.length; c++) {
      if (widget.category == mappedData[c]["category"]) {
        finalmappedData.add(mappedData[c]);
      }
    }
    setState(() {
      currentZekrCounts.length = finalmappedData.length;
      currentZekrCounts.fillRange(0, currentZekrCounts.length, 0);
      print(" currentZekrCounts ${currentZekrCounts.length} +++====++++");
    });
    print("We have ${finalmappedData.length} sub items for ${widget.category}");
    FileUtils.readFromFile().then((contents) {
      if (contents.contains(widget.category)) {
        setState(() {
          isFavourite = true;
        });
      }
    });
    super.initState();
  }

  void _showMySnackBar(BuildContext context, String message) {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        BackgroundShapes(
          isInsideZekrPage: true,
        ),
        SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            drawerScrimColor: Theme.of(context).bottomAppBarColor,
            endDrawer: Mesbaha(),
            appBar: AppBar(
              automaticallyImplyLeading: true,

              title: Hero(
                tag: widget.category,
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    widget.category,
                    style: Theme.of(context)
                        .appBarTheme
                        .textTheme
                        .headline
                        .apply(fontSizeDelta: -3.0),
                    maxLines: 2,
                    // textAlign: TextAlign.center,
                    strutStyle: StrutStyle(height: 1.6),
                  ),
                ),
              ),
              // centerTitle: true,
              actions: <Widget>[
                ScopedModelDescendant<UserScopedModel>(
                    builder: (context, child, model) {
                  return InkWell(
                    onTap: () {
                      model.switchFont();
                    },
                    child: Tooltip(
                      message: "اضغط لتغيير نوع الخط",
                      child: CircleAvatar(
                        backgroundColor:
                            //Theme.of(context).accentColor.withOpacity(0.6),
                            Theme.of(context)
                                .accentColor
                                .withRed(1200)
                                .withOpacity(0.65),
                        maxRadius: 20.0,
                        minRadius: 8.0,
                        child: Text(
                          "خط",
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(
                  width: 12.0,
                ),
                SwitchThemeButton(),
                SizedBox(
                  width: 12.0,
                ),
              ],
            ),
            floatingActionButton: Align(
              alignment: Alignment(0.830, 1.0),
              child: Fab(
                message: "إضافة للمفضلة",
                child: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).appBarTheme.iconTheme.color,
                ),
                onpressed: () async {
                  print("fav is clicked @");
                  setState(() {
                    isFavourite = !isFavourite;
                    FileUtils.saveToFile(widget.category);
                    String _message = isFavourite
                        ? "تمت إضافة هذا الذكر إلى المفضلة"
                        : "تم حذف هذا الذكر من المفضلة";
                    _showMySnackBar(context, _message);
                  });
                },
              ),
            ),
            body: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                      cacheExtent: 100.0,
                      itemCount: finalmappedData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ZekrDetailsElement(
                          category: widget.category,
                          zekr: finalmappedData[index]["zekr"],
                          description: finalmappedData[index]["description"],
                          zekrCount: finalmappedData[index]["count"],
                          index: index,
                          length: finalmappedData.length,
                        ); //qqqqqqqq
                      }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Function to show top notifications when an element is added or removed from favourites list

}

///fsfsfsfsfsfsfs
/// This Statefullwidget class is responsible for showing
/// the zekr details element with a sub Mesbaha inside it.

class ZekrDetailsElement extends StatefulWidget {
  final String zekr;
  final String description;
  final String zekrCount;
  final String newFont;
  final String category;
  final int length;
  final index;

  ZekrDetailsElement(
      {this.zekr,
      this.description,
      this.zekrCount,
      this.newFont = "Abdo Master",
      this.index,
      this.length,
      this.category});

  @override
  _ZekrDetailsElementState createState() => _ZekrDetailsElementState();
}

class _ZekrDetailsElementState extends State<ZekrDetailsElement>
    with TickerProviderStateMixin {
  int upCounter = 0;
  int zekrCountAsInteger;

  AnimationController animationController;
  AnimationController flipAnimationController;
  Animation<double> animation;
  Animation<double> flipAnimation;

  @override
  void initState() {
    setState(() {
      upCounter = currentZekrCounts[widget.index];
    });
    zekrCountAsInteger = int.parse(this.widget.zekrCount);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    flipAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    final Animation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    final Animation curve2 =
        CurvedAnimation(parent: flipAnimationController, curve: Curves.easeIn);
    animation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      curve,
    );
    flipAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      curve2,
    );

    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.reverse();
    animationController.dispose();
    flipAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _menAzkarKaza =
        widget.length > 1 ? "من" : ''; //add word من azkar kaza when it's shared
    var arabicNumber = "مرة واحدة";
    switch (this.widget.zekrCount) {
      case "3":
        arabicNumber = "ثلاث مرات";
        break;
      case "4":
        arabicNumber = "أربع مرات";
        break;
      case "7":
        arabicNumber = "سبع مرات";
        break;
      case "10":
        arabicNumber = "عشر مرات";
        break;
      case "33":
        arabicNumber = "ثلاثاً وثلاثين";
        break;
      case "34":
        arabicNumber = "أربعاً وثلاثين";
        break;
      case "100":
        arabicNumber = "مائة مرة";
        break;
    }
    return ScaleTransition(
      scale: animation,
      alignment: Alignment.centerRight,
      child: Center(
        child: InkWell(
          highlightColor: Colors.transparent, //good
          splashColor: Colors.transparent, //good

          onTap: () {
            setState(() {
              if (upCounter < zekrCountAsInteger) {
                upCounter++;
                currentZekrCounts[widget.index]++;
                debugPrint('\nyou should say it $zekrCountAsInteger times');
                if (upCounter == zekrCountAsInteger) {
                  if (flipAnimationController.isDismissed) {
                    flipAnimationController.forward();
                    print("flip occured !");
                  } else {
                    print("No Flip  !");
                  }
                }
              }
            });
          },
          onLongPress: () {
            if (widget.description != '') {
              Share.share(_menAzkarKaza +
                  ' ' +
                  widget.category +
                  '\n' +
                  widget.description +
                  "\n...............\n" +
                  widget.zekr +
                  "\n- تطبيق أذكاري -");
            } else {
              Share.share(_menAzkarKaza +
                  ' ' +
                  widget.category +
                  '\n' +
                  widget.zekr +
                  "\n- تطبيق أذكاري -");
            }
          },
          child: Container(
            height: null,
            margin: EdgeInsets.only(top: 6.0, right: 8.0, left: 8.0),

            /// if you want to animate it as an AnimatedContainer  then change its height from 0.0 to null
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0,
                    color: Colors.black45.withOpacity(0.45))
              ],
              borderRadius: BorderRadius.only(
                topLeft: this.widget.index == 0
                    ? Radius.circular(30.0)
                    : Radius.circular(10.0),
                topRight: this.widget.index == 0
                    ? Radius.circular(30.0)
                    : Radius.circular(10.0),
                bottomLeft: this.widget.index == this.widget.length - 1
                    ? Radius.circular(30.0)
                    : Radius.circular(10.0),
                bottomRight: this.widget.index == this.widget.length - 1
                    ? Radius.circular(30.0)
                    : Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 12.0, right: 12.0, bottom: 10.0),
              child: Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    ///[container] has a row inside which contains
                    ///Zekr desctiptio icon if it's found for this specific Zekr
                    ///and the index of this zekr relatively to the [Zekr list]
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 35.0,
                        color: Colors.red.withOpacity(0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            ///This text show the [order] and the index of this zekr

                            Text(
                              "${widget.index + 1} من ${widget.length}",
                              style: Theme.of(context).textTheme.display4,
                            ),

                            widget.description != ""
                                ? IconButton(
                                    icon: Icon(
                                      Icons.info,
                                    ),
                                    onPressed: () {
                                      print("this is infoooo");
                                      showModalBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) => Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30.0),
                                                    topRight:
                                                        Radius.circular(30.0),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: GestureDetector(
                                                    // onLongPress: () {
                                                    //   Share.share(widget
                                                    //           .description +
                                                    //       "\n [${widget.zekr}]\n -تطبيق أذكاري -");
                                                    // },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              28.0),
                                                      child:
                                                          SingleChildScrollView(
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Text(
                                                              widget
                                                                  .description,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .body2,
                                                              strutStyle:
                                                                  StrutStyle(
                                                                      height:
                                                                          2.0,
                                                                      forceStrutHeight:
                                                                          true),
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            IconButton(
                                                              highlightColor:
                                                                  Colors.red,
                                                              tooltip: "شارك",
                                                              icon: Icon(
                                                                Icons.share,
                                                                size: 35.0,
                                                              ),
                                                              onPressed: () {
                                                                Share.share(_menAzkarKaza +
                                                                    ' ' +
                                                                    widget
                                                                        .category +
                                                                    '\n' +
                                                                    widget
                                                                        .description +
                                                                    "\n...............\n" +
                                                                    widget
                                                                        .zekr +
                                                                    "\n- تطبيق أذكاري -");
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ));
                                    },
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              this.widget.zekr,
                              textAlign: TextAlign.center,
                              strutStyle: StrutStyle(
                                height: 1.8,
                                forceStrutHeight: true,
                              ),
                              style: Theme.of(context).textTheme.body2.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                  ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),

                        ///
                        /// The number of this zekr to be said .

                        AnimatedBuilder(
                          animation: flipAnimation,
                          child: Container(
                            child: Container(
                              width: null,
                              height: null,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(150.0),
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).accentColor
                                  ],
                                ),
                              ),
                              constraints: BoxConstraints(
                                  minWidth: 80.0,
                                  maxWidth: 90.0,
                                  minHeight: 30.0,
                                  maxHeight: 35.0),
                              child: Center(
                                /// If there is a description for this specific zekr then
                                /// the text will shine in a Shimmer Widget Else Normal text Widget .
                                child: Text(
                                  upCounter != 0
                                      ? "$upCounter \\ $zekrCountAsInteger"
                                      : arabicNumber, //ccccccc
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0),
                                ),
                              ),
                            ),
                          ),
                          builder: (context, widget) {
                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationX(
                                  flipAnimationController.value * pi * 2.0),
                              child: widget,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///[this code is related to the navigation buttons were found before editing]
// Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     FloatingActionButton(
//                         heroTag: "456",
//                         backgroundColor: darkColor1.withOpacity(0.5),
//                         tooltip: "الصعود إلى الأعلى",
//                         isExtended: true,
//                         elevation: 0.0,
//                         child: Icon(
//                           Icons.keyboard_arrow_up,
//                           size: 25.0,
//                           color: Colors.white,
//                         ),
//                         onPressed: () {
//                           //dddddddddddd
//                           if (_listViewController.offset >=
//                                   _listViewController.position.minScrollExtent +
//                                       0.35 * screenHeight &&
//                               !_listViewController.position.outOfRange) {
//                             _listViewController.animateTo(
//                                 _listViewController.offset -
//                                     screenHeight +
//                                     100.0,
//                                 duration: Duration(seconds: 1),
//                                 curve: Interval(0.0, 0.9,
//                                     curve: Curves.easeInOut));
//                           } else {
//                             _listViewController.animateTo(0.0,
//                                 duration: Duration(seconds: 1),
//                                 curve: Curves.fastLinearToSlowEaseIn);
//                           }
//                         }),
//                     SizedBox(
//                       height: 5.0,
//                     ),
//                     FloatingActionButton(
//                         heroTag: "123",
//                         backgroundColor: darkColor1.withOpacity(0.5),
//                         tooltip: "النزول إلى الأسفل",
//                         isExtended: true,
//                         elevation: 0.0,
//                         child: Icon(
//                           Icons.keyboard_arrow_down,
//                           size: 25.0,
//                           color: Colors.white,
//                         ),
//                         onPressed: () {
//                           //dddddddddddd
//                           if (_listViewController.offset <=
//                               _listViewController.position.maxScrollExtent -
//                                   0.3 * screenHeight) {
//                             _listViewController.animateTo(
//                                 _listViewController.offset +
//                                     screenHeight -
//                                     150.0,
//                                 duration: Duration(seconds: 1),
//                                 curve: Interval(0.0, 0.9,
//                                     curve: Curves.easeInOut));
//                           } else {
//                             _listViewController.animateTo(
//                                 _listViewController.position.maxScrollExtent,
//                                 duration: Duration(seconds: 1),
//                                 curve: Curves.fastLinearToSlowEaseIn);
//                           }
//                         })
//                   ],
//                 )
