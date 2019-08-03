import 'package:azkar/colors/colors.dart';
import 'package:azkar/screens/push_notification_test_methods.dart';
import 'package:azkar/screens/zekr_details.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:azkar/screens/zekr_title.dart';

import 'about_app.dart';
import 'about_developper.dart';
import 'azkar_categories_list.dart';

import 'favourites.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> mappedData = mappedJson;
  final List<String> onlyAzkarList = [];
  var finalCategoryList = [];
  var _enableNotifivations = true;
  final FlutterLocalNotificationsPlugin notification =
  FlutterLocalNotificationsPlugin();
  final FlutterLocalNotificationsPlugin notification2 =
  FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    var androidSettings = AndroidInitializationSettings('app_icon');
    var IOSSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));
    notification.initialize(
        InitializationSettings(androidSettings, IOSSettings),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    notification.cancelAll();
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ZekrList.fromFont(
                  category: payload,
                  font: 'Tajawal',
                )));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    EnableNotifications.readFromFile().then((contents) {
      var filecontenst = contents;
      if (filecontenst == '') {
        showNotification3(
            notification: notification,
            channelId: 1,
            title: "أذكار الصباح",
            time: Time(4, 30, 0));
        showNotification3(
            notification: notification,
            channelId: 2,
            title: "أذكار المساء",
            time: Time(16, 0, 0));
        showNotification3(
            notification: notification,
            channelId: 3,
            title: "أذكار الاستيقاظ من النوم",
            time: Time(7, 0, 0));
        showNotification3(
            notification: notification,
            channelId: 4,
            title: "أذكار النوم",
            time: Time(23, 0, 0));
        debugPrint('notifications enabled');
        EnableNotifications.enable();
      } else {
        debugPrint("any habal");
      }
    });

    for (int c = 0; c < mappedData.length; c++) {
      onlyAzkarList.add(mappedData[c]["category"]);
    }
    finalCategoryList = onlyAzkarList.toSet().toList();
    debugPrint("nuber of ${finalCategoryList.length}");

    return SafeArea(
      top: true,
      bottom: true,
      child: Stack(
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
            endDrawer: Mesbaha(),
            backgroundColor: Colors.transparent,
            drawerDragStartBehavior: DragStartBehavior.down,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Tooltip(
                    message: 'قائمة الأذكار المفضلة',
                    child: IconButton(
                        icon: Icon(
                          Icons.stars,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => FavouriteList()));
                        }),
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
              title: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "قائمة الأذكار",
                  textScaleFactor: 0.9,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24.0),
                  textDirection: TextDirection.rtl,
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
            ),
            drawerScrimColor: brightColor1,
            drawer: _myDrawer(),
            body: ZekrTitle(finalCategoryList),
          ),
        ],
      ),
    );
  }

  Widget _myDrawer() {
    return Drawer(
      child: Flex(direction: Axis.vertical, children: [
        Expanded(
          child: Container(
            color: darkColor1,
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  margin: EdgeInsets.only(bottom: 50.0),
                  child: null,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/drawerbg.jpg'),
                          fit: BoxFit.cover)),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => Mesbaha()));
                  },
                  title: Text(
                    "المسبحة الإلكترونية",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  leading: Icon(
                    Icons.donut_large,
                    color: Colors.white,
                  ),
                ),
                Divider(
                  height: 2.0,
                  color: brightColor1,
                  endIndent: 150.0,
                ),
                Hero(
                  tag: 'app info',
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (context) => AboutApp()));
                    },
                    title: Text(
                      "عن التطبيق",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    leading: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                  ),
                ),
                Divider(
                  height: 2.0,
                  color: brightColor1,
                  indent: 150.0,
                ),
                Hero(
                  tag: 'developer info',
                  child: ListTile(
                    title: Text(
                      "عن المطوِّر",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    leading: Icon(
                      Icons.developer_mode,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => AboutDeveloper()));
                    },
                  ),
                ),
                Divider(
                  height: 2.0,
                  color: brightColor1,
                  endIndent: 150.0,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class Mesbaha extends StatefulWidget {
  @override
  _MesbahaState createState() => _MesbahaState();
}

class _MesbahaState extends State<Mesbaha> {
  int _counter = 0;
  Color _counterColor = brightColor1;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    var screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Stack(
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: darkColor1,
              leading: IconButton(
                color: brightColor1,
                highlightColor: Colors.white,
                splashColor: Colors.white,
                icon: Icon(
                  Icons.arrow_back,
                  color: brightColor1,
                  size: 25.0,
                ),
                onPressed: () async {
                  setState(() {
                    return Navigator.of(context).pop();
                  });
                },
              ),
              actions: <Widget>[
                Icon(
                  Icons.donut_large,
                  color: brightColor1,
                ),
                SizedBox(width: 15.0,)
              ],
              elevation: 0.0,
              automaticallyImplyLeading: false,
              title: Text(
                "المسـبـحة",
                style: TextStyle(color: brightColor1),
                maxLines: 2,
              ),
              centerTitle: true,
            ),
            body: Container(
              width: screenWidth,
              height: screenHeight,
              color: darkColor1,
              child: Center(
                child: Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.spaceEvenly,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 15.0,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _counter = 0;
                          _counterColor = brightColor1;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: _counter != 0
                            ? Chip(
                          label: Text(
                            "تصفير العداد",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          labelPadding: EdgeInsets.all(15.0),
                          backgroundColor: Colors.white,
                        )
                            : null,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _counter++;
                          if (_counter > 32 && _counter < 66) {
                            _counterColor = Colors.lightGreen;
                          } else if (_counter > 65 && _counter < 100) {
                            _counterColor = Colors.teal;
                          } else if (_counter > 99) {
                            _counterColor = Colors.orange;
                          }
                        });
                      },
                      child: Card(
                        shape: CircleBorder(side: BorderSide()),
                        elevation: 20.0,
                        child: CircleAvatar(
                          backgroundColor: _counterColor,
                          //minRadius: 110.0,
                          maxRadius: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            _counter != 0 ? _counter.toString() : "ابدأ",
                            style: TextStyle(fontSize: 70.0, color: darkColor1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        )
      ],
    );
  }
}
