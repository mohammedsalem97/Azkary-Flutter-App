import 'dart:async';
import 'dart:ui';

import 'package:azkar/screens/prayertimes.dart';
import 'package:azkar/screens/push_notification_test_methods.dart';

import 'package:azkar/screens/zekr_details.dart';
import 'package:azkar/widgets/FAB.dart';
import 'package:azkar/widgets/background_shapes.dart';

import 'package:azkar/widgets/search_screen.dart';
import 'package:azkar/widgets/switch_theme_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:azkar/screens/zekr_title.dart';

import 'about_app.dart';

import 'azkar_categories_list.dart';

import 'favourites.dart';
import 'islamyOnline/islamyOnline.dart';

import 'mesbaha.dart';

///tobeedited
///[1-welcome message saying "صلوا على الحبيب"]
///[2-Images from AbdoFonts sending some moral messages like "ولا تنازعوا فتفشلوا - ومن يتق الله يجعل له مخرجاً" ]
///[3-modify Favourites page to be beautiful and add the ability to remove items from it easily]
///=====>[4-add a fav icon to the titles to easily add them to the fav list without entering the zekr page and toggle it]
///=====>[5-change the height of the titles to be 55.0 or 60.0]
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> mappedData = mappedJson;
  final List<String> onlyAzkarList = [];
  var finalCategoryList = [];

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin notification =
      FlutterLocalNotificationsPlugin();

  ///[firebaseMessaging reaction]
  Future firebaseMessagingHandler(Map<String, dynamic> message) async {
    var buttonText = message["data"]["btn_text"] ?? "ذهاب";
    Function onButtonPressed;
    String dialogueBGImageUrl = message["data"]["bg_image"] ??
        "https://images.unsplash.com/photo-1487800940032-1cf211187aea?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1349&q=80";
    switch (message["data"]["data_type"]) {
      case "video":
        onButtonPressed = () {
          Navigator.pop(context);
          Launcher.launch(message["data"]["url"]);
        };
        break;
      case "article":
        onButtonPressed = () {
          Navigator.pop(context);
          Launcher.launch(message["data"]["url"]);
        };

        break;
      case "update":
        onButtonPressed = () {
          Navigator.pop(context);
          Launcher.launch(message["data"]["url"]);
        };
        break;
      case "zekr":
        onButtonPressed = () async {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ZekrList(
                    category: message["data"]["category"],
                  )));
        };
        break;
      case "mesbaha":
        onButtonPressed = () async {
          Navigator.pop(context);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Mesbaha()));
        };
        break;
      default:
        onButtonPressed = () => Navigator.pop(context);

        print("NO DATA CORRECT RECIEVED");
        break;
    }
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            child: Container(
              child: SimpleDialog(
                contentPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          //Color(0xffb24592),
                          Color(0xfff15f79),
                          Color(0xff583C87),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          dialogueBGImageUrl,
                        ),
                        fit: BoxFit.cover,
                        repeat: ImageRepeat.noRepeat,
                        colorFilter: ColorFilter.mode(
                            Color(0xff583C87), BlendMode.multiply),
                      ),
                    ),
                    height: 200,
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${message["data"]["header"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            message["data"]["message_line"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                            strutStyle:
                                StrutStyle(height: 1.5, forceStrutHeight: true),
                          )
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                    onTap: onButtonPressed,
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                        color: Color(0xff583C87), //bottombutton
                      ),
                      child: Center(
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            shadows: [
                              Shadow(
                                  blurRadius: 3.0,
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(2.0, 2.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([]);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        Map<String, dynamic> messageData = message["data"];
        String messageDataType = messageData["data_type"].toString();
        print(
            "================================\nrecived from onmessage\n ${message["data"]["data_type"]} \n=====================");
        print("title is +++++ ${message["title"]}");
        firebaseMessagingHandler(message);

        ///[put ما رأيك أن تصوم غداً يا صديقي in a dialog box]
      },
      onLaunch: (Map<String, dynamic> message) async {
        //print("recived a message when i am Launched $message");
        print(
            "================================\nrecived from onLaunch\n ${message["data"]["data_type"]} \n=====================");
        firebaseMessagingHandler(message);
      },
      onResume: (Map<String, dynamic> message) async {
        //print("recived a message when i am closed $message");
        print(
            "================================\nrecived from onresume\n ${message["data"]["data_type"]} \n=====================");
        firebaseMessagingHandler(message);
        // Launcher.launch(
        //     "https://youtu.be/TYomFCJ2oSg?t=166"); //Mostafa hosny's video about Syam Nawafel
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(alert: true, badge: true, sound: true));
    showMySnack(context);

    for (int c = 0; c < mappedData.length; c++) {
      onlyAzkarList.add(mappedData[c]["category"]);
    }
    finalCategoryList = onlyAzkarList.toSet().toList();
    debugPrint("number of ${finalCategoryList.length}");
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getBool("notifEnabled") != true) {
        // showNotification3(
        //     notification: notification,
        //     channelId: 3,
        //     title: "أذكار الاستيقاظ من النوم",
        //     time: Time(7, 0, 0));
        // showNotification3(
        //     notification: notification,
        //     channelId: 4,
        //     title: "أذكار النوم",
        //     time: Time(23, 0, 0));
        // debugPrint('notifications enabled');
        // prefs.setBool("notifEnabled", true);
        debugPrint("Now waking and sleeping notifications are activated !");
      } else {
        debugPrint("Notification for waking and sleeping are activated lately");
      }
    });
  }

  Future onSelectNotification(String payload) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ZekrList(
                  category: payload,
                )));
  }

  void showMySnack(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).whenComplete(() {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "من صلَّى عليَّ صلاة صلَّى الله عليه بها عشراً",
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 5),
      ));
    });
    //Future.delayed(Duration(seconds: 2)).whenComplete(() {

    //   Scaffold.of(context).showSnackBar(SnackBar(
    //     content: Text("salaton 3layka"),
    //     duration: Duration(seconds: 1),
    //   ));
    // });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(milliseconds: 100)).whenComplete(() {
    //   if (_salahEnable) {
    //     toast("من صلًى علَيَّ صّلاةً صَلَّى الله عَلَيهِ بِها عَشْراً",
    //         duration: Duration(seconds: 5));
    //     _salahEnable = false;
    //   }
    // });
    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TodayQuate()));
    List<Widget> _body = [ZekrTitle(finalCategoryList), PrayerTimes()];
    List<Widget> _appBars = [buildAzkarAppBar(context), null];
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
          child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          BackgroundShapes(),
          SafeArea(
            top: true,
            bottom: true,
            left: true,
            right: true,
            child: Scaffold(
              key: _scaffoldKey,
              primary: true,
              endDrawer: Mesbaha(),
              backgroundColor: Colors.transparent,
              appBar: _appBars[_pageIndex],
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: (_pageIndex == 0)
                  ? Fab(
                      message: "بحث عن ذكر",
                      elevation: 10.0,
                      child: Icon(
                        Icons.search,
                        color: Theme.of(context).appBarTheme.iconTheme.color,
                      ),
                      onpressed: () {
                        showSearch(
                            context: context,
                            delegate:
                                AzkarSearch(fullAzkarList: finalCategoryList));
                        debugPrint("i was tapped!");
                        //showMySnack(context);
                        // Navigator.of(context).push(
                        //     CupertinoPageRoute(builder: (context) => TodayQuate()));
                      },
                    )
                  : null,
              drawer: _myDrawer(),
              drawerScrimColor: Colors.black.withOpacity(0.5),
              body: _body[_pageIndex],
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ]),
                ),
                child: BottomNavigationBar(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.white.withOpacity(0.5),
                    selectedIconTheme:
                        IconThemeData(size: 20.0, color: Colors.white),
                    selectedFontSize: 10.0,
                    unselectedFontSize: 8.0,
                    currentIndex: _pageIndex,
                    onTap: (index) {
                      setState(() {
                        _pageIndex = index;
                      });
                    },
                    items: [
                      BottomNavigationBarItem(
                          icon: FaIcon(FontAwesomeIcons.list),
                          title: Text("قائمة الأذكار")),
                      BottomNavigationBarItem(
                          icon: FaIcon(FontAwesomeIcons.mosque),
                          title: Text("أوقات الصلاة")),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAzkarAppBar(BuildContext context) {
    return AppBar(
      actions: [
        Tooltip(
          message: 'قائمة الأذكار المفضلة',
          child: IconButton(
              icon: Icon(
                Icons.favorite,
                size: 25.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FavouriteList()));
              }),
        ),
        SizedBox(
          width: 8.0,
        ),
        SwitchThemeButton(),
        SizedBox(
          width: 10.0,
        )
      ],
      centerTitle: true,
      title: Text(
        "قائمة الأذكار",
        textScaleFactor: 0.9,
        style: Theme.of(context).appBarTheme.textTheme.headline.copyWith(
            fontSize:
                15.0), //TextStyle(fontWeight: FontWeight.w900, fontSize: 20.0),
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Widget _myDrawer() {
    var _divider = Divider(
      height: 0.0,
      thickness: 1.0,
      color: Colors.white30,
    );
    var _drawerItemTextStyle = Theme.of(context)
        .textTheme
        .body1
        .copyWith(color: Colors.white, fontSize: 12.0);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Flex(direction: Axis.vertical, children: [
        Expanded(
          child: Container(
            color: Color(0xFF0E262E), //tobeedited
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: null,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/drawerbg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => Mesbaha()));
                  },
                  title: Text(
                    "المسبحة الإلكترونية",
                    style: _drawerItemTextStyle,
                  ),
                  leading: Icon(
                    Icons.donut_large,
                    size: 22.0,
                    color: Colors.amber,
                  ),
                ),
                _divider,
                ListTile(
                  title: Text(
                    "إسلامي أونلاين",
                    style: _drawerItemTextStyle,
                  ),
                  leading: Hero(
                    tag: 'islamyOnline',
                    child: Icon(
                      Icons.radio,
                      size: 22.0,
                      color: Colors.amber,
                    ),
                  ),
                  trailing: new NewFeatureLabel(),
                  onTap: () {
                    //Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => IslamyOnline()));
                  },
                ),
                _divider,
                ListTile(
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => AboutApp()));
                  },
                  title: Text(
                    "عن التطبيق",
                    textDirection: TextDirection.rtl,
                    style: _drawerItemTextStyle,
                  ),
                  leading: Hero(
                    tag: 'app info',
                    child: Icon(
                      Icons.info,
                      size: 22.0,
                      color: Colors.amber,
                    ),
                  ),
                ),
                _divider,
                ListTile(
                  onTap: () {
                    Launcher.launch("https://bit.ly/AzkaryApp-fb");
                  },
                  title: Text(
                    "اقترح ميزات",
                    style: _drawerItemTextStyle,
                  ),
                  leading: Icon(
                    // Icons.feedback,
                    Icons.mail_outline,
                    size: 22.0,
                    color: Colors.amber,
                  ),
                ),
                _divider,
                ListTile(
                  onTap: () {
                    Launcher.launch("https://bit.ly/AzkaryApp-fb");
                  },
                  title: Text(
                    "إبلاغ عن مشكلة",
                    style: _drawerItemTextStyle,
                  ),
                  leading: Icon(
                    Icons.feedback,
                    size: 22.0,
                    color: Colors.amber,
                  ),
                ),
                _divider,
                ListTile(
                  onTap: () {
                    Share.share("تحميل تطبيق أذكاري لهواتف الأندرويد 👇\n"
                        "https://bit.ly/AzkaryApp-fb");
                  },
                  title: Text(
                    "شارك التطبيق",
                    style: _drawerItemTextStyle,
                  ),
                  leading: Icon(
                    Icons.share,
                    size: 22.0,
                    color: Colors.amber,
                  ),
                ),
                _divider,
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class NewFeatureLabel extends StatelessWidget {
  const NewFeatureLabel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "جديد",
        style: TextStyle(color: Colors.white, fontSize: 10.0),
      ),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
