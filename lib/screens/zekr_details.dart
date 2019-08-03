import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:azkar/colors/colors.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shimmer/shimmer.dart';

import 'azkar_categories_list.dart';
import 'favourites.dart';
import 'home_screen.dart';

class ZekrList extends StatefulWidget {
  final String category;

  ZekrList({this.category});

  String font = '';

  ZekrList.fromFont({this.category, this.font = 'Tajawal'});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ZekrListState.fromFont(category: this.category, font: this.font);
  }
}

class _ZekrListState extends State<ZekrList> {
  final List<Map<String, String>> mappedData = mappedJson;

  final String category;

  _ZekrListState({this.category});

  String font = 'Tajawal';

  _ZekrListState.fromFont({this.category, this.font = 'Tajawal'});

  ScrollController _listViewController;

  _scrollListener() {}

  @override
  void initState() {
    _listViewController = ScrollController();
    _listViewController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> finalmappedData = [];
    double screenHeight = MediaQuery.of(context).size.height;
    for (int c = 0; c < mappedData.length; c++) {
      if (this.category == mappedData[c]["category"]) {
        finalmappedData.add(mappedData[c]);
      }
    }
    print("We have ${finalmappedData.length} sub items for ${this.category}");
    String newFont = this.font;

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: <Color>[
              brightColor1, // The Bright color of the theme
              darkColor1, // The dark color of the theme
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          drawerScrimColor: brightColor1,
          endDrawer: Mesbaha(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: GestureDetector(
              onLongPress: () {
                setState(() {
                  FileUtils.saveToFile(this.category);
                  FileUtils.readFromFile().then((contents) {
                    if (contents.contains(this.category)) {
                      _notifyIfAdded("تمت إزالة هذا الذكر من المفضلة");
                    } else {
                      _notifyIfAdded("تمت إضافة هذا الذكر إلى المفضلة");
                    }
                  }).whenComplete(() {});
                  //cccccccc
                  print(
                      "\n '${this.category}' SUCCESSFULLY ADDED TO THE LIST\n ");
                });
              },
              child: Hero(
                tag: this.category,
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    this.category,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: this.category.length > 14 ? 17.0 : 20.0,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            centerTitle: true,
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  //setState(() {
                  if (newFont == 'Tajawal') {
                    newFont = 'FFKhallab';
                    Navigator.of(context).pop();
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (buildContext) => ZekrList.fromFont(
                              category: this.category,
                              font: newFont,
                            )));
                  } else {
                    newFont = 'Tajawal';
                    Navigator.of(context).pop();
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (buildContext) => ZekrList.fromFont(
                              category: this.category,
                              font: newFont,
                            )));
                  }
//                  });
                },
                child: Tooltip(
                  message: "اضغط لتغيير نوع الخط",
                  child: CircleAvatar(
                    backgroundColor: darkColor1.withOpacity(0.6),
                    maxRadius: 20.0,
                    minRadius: 8.0,
                    child: Text(
                      "خط",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 12.0,
              )
            ],
          ),
          floatingActionButton: finalmappedData.length >= 4
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton(
                        heroTag: "456",
                        backgroundColor: darkColor1.withOpacity(0.5),
                        tooltip: "الصعود إلى الأعلى",
                        isExtended: true,
                        elevation: 0.0,
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          //dddddddddddd
                          if (_listViewController.offset >=
                                  _listViewController.position.minScrollExtent +
                                      0.35 * screenHeight &&
                              !_listViewController.position.outOfRange) {
                            _listViewController.animateTo(
                                _listViewController.offset -
                                    screenHeight +
                                    100.0,
                                duration: Duration(seconds: 1),
                                curve: Interval(0.0, 0.9,
                                    curve: Curves.easeInOut));
                          } else {
                            _listViewController.animateTo(0.0,
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn);
                          }
                        }),
                    SizedBox(
                      height: 5.0,
                    ),
                    FloatingActionButton(
                        heroTag: "123",
                        backgroundColor: darkColor1.withOpacity(0.5),
                        tooltip: "النزول إلى الأسفل",
                        isExtended: true,
                        elevation: 0.0,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          //dddddddddddd
                          if (_listViewController.offset <=
                              _listViewController.position.maxScrollExtent -
                                  0.3 * screenHeight) {
                            _listViewController.animateTo(
                                _listViewController.offset +
                                    screenHeight -
                                    150.0,
                                duration: Duration(seconds: 1),
                                curve: Interval(0.0, 0.9,
                                    curve: Curves.easeInOut));
                          }else {
                            _listViewController.animateTo(_listViewController.position.maxScrollExtent,
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn);
                          }
                        })
                  ],
                )
              : Container(
                  width: 0.0,
                  height: 0.0,
                ),
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                    itemCount: finalmappedData.length,
                    physics: BouncingScrollPhysics(),
                    controller: _listViewController,
                    itemBuilder: (context, index) {
                      var arabicNumber = "مرة واحدة";
                      switch (finalmappedData[index]["count"]) {
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
                        case "100":
                          arabicNumber = "مائة مرة";
                          break;
                      }
                      return GestureDetector(
                        onLongPress: () {
                          if (finalmappedData[index]["description"] != "") {
                            showDialog(
                                context: context,
                                child: CupertinoAlertDialog(
                                  content: Container(
                                      width: null,
                                      height: 270.0, //310.0
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(45.0),
                                          bottomLeft: Radius.circular(45.0),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            brightColor1,
                                            // The Bright color of the theme
                                            darkColor1,
                                            // The dark color of the theme
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        border: Border.all(
                                            color: Colors.white, width: 4.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15.0,
                                            bottom: 15.0,
                                            left: 20.0,
                                            right: 20.0),
                                        child: Center(
                                          child: Text(
                                            finalmappedData[index]
                                                ["description"],
                                            textScaleFactor: 1.42,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Tajawal'),
                                          ),
                                        ),
                                      )),
                                ));
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 6.0, right: 8.0, left: 8.0),
                            child: Container(
                              height: null,

                              /// if you want to animate it as an AnimatedContainer  then change its height from 0.0 to null
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: index == 0
                                      ? Radius.circular(20.0)
                                      : Radius.circular(5.0),
                                  topRight: index == 0
                                      ? Radius.circular(20.0)
                                      : Radius.circular(5.0),
                                  bottomLeft:
                                      index == finalmappedData.length - 1
                                          ? Radius.circular(20.0)
                                          : Radius.circular(5.0),
                                  bottomRight:
                                      index == finalmappedData.length - 1
                                          ? Radius.circular(20.0)
                                          : Radius.circular(5.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 12.0,
                                    right: 12.0,
                                    bottom: 10.0),
                                child: Center(
                                  child: Column(
                                    textDirection: TextDirection.rtl,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            finalmappedData[index]["zekr"],
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: newFont == 'Tajawal'
                                                    ? 16.0
                                                    : 20.0,
                                                fontWeight: newFont == 'Tajawal'
                                                    ? FontWeight.w500
                                                    : FontWeight.w400,
                                                height: newFont == 'Tajawal'
                                                    ? 1.05
                                                    : 1.0,
                                                fontFamily: font,
                                                color: darkColor1),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Container(
                                        width: null,
                                        height: null,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(150.0),
                                          gradient: LinearGradient(
                                            colors: [brightColor1, darkColor1],
                                          ),
                                        ),
                                        constraints: BoxConstraints(
                                            minWidth: 80.0,
                                            maxWidth: 80.0,
                                            minHeight: 30.0,
                                            maxHeight: 35.0),
                                        child: Center(
                                          child: Text(
                                            arabicNumber, //ddddd
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Function to show top notifications when an element is added or removed from favourites list
  void _notifyIfAdded(String message) {
    showSimpleNotification(
        Shimmer(
            gradient: LinearGradient(colors: [goldColor, Color(0xffffd802)]),
            child: Text(
              message,
              style: TextStyle(color: goldColor),
              textAlign: TextAlign.right,
            )),
        background: darkColor1,
        trailing: IconButton(
          icon:Icon(Icons.stars),
          color: goldColor,
          onPressed: (){
            Navigator.of(context).push(CupertinoPageRoute(builder: (context) => FavouriteList()));
          },
        ),
        foreground: Colors.white);
  }
}
