import 'dart:io';
import 'dart:ui';
import 'package:azkar/widgets/background_shapes.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:azkar/screens/zekr_details.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;

import 'mesbaha.dart';

///tobeedited
///[1-Renove items easily by swiping thim "Dismissible()"]

final List<String> favouriteAzkar = [];

class FavouriteList extends StatefulWidget {
  @override
  _FavouriteListState createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  String fileContent = "";
  List<String> favListItems = [];

  ///firebase nessageing test for showing message data in a Simple dialog
  Future firebaseMessagingHandlerTest() async {
    ///Do not forget to show a specific message depending on the type
    ///of the set message either a [url to redirect to or just a text message]
    Map<String, dynamic> message = {
      "data": {
        "data_type": "zekr",

        ///[message] or [video] or [zekr] or [update]
        "header": "عنوان الرسالة",
        "message_line":
            "من صام يوماً في سبيل الله باعد الله وجهه عن النار سبعين خريفاً",
        "url": "https://www.youtube.com/watch?v=6JOyW0fvKYE",
        "bg_image":
            "https://images.unsplash.com/photo-1487800940032-1cf211187aea?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1349&q=80",
        "category": "أذكار الصباح",

        ///video or article [url] here
      },
    };

    var buttonText = "ذهاب";
    Function onButtonPressed;
    String dialogueBGImageUrl = message["data"]["bg_image"] ??
        "https://images.unsplash.com/photo-1487800940032-1cf211187aea?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1349&q=80";
    switch (message["data"]["data_type"]) {
      case "video":
        buttonText = "مشاهدة الفيديو";
        onButtonPressed = () {
          Navigator.pop(context);
          Launcher.launch(message["data"]["url"]);
        };
        break;
      case "article":
        buttonText = "قراءة المقال";
        onButtonPressed = () {
          Navigator.pop(context);
          Launcher.launch(message["data"]["url"]);
        };
        break;
        break;
      case "update":
        buttonText = "تحديث التطبيق";
        onButtonPressed = () {
          Navigator.pop(context);
          Launcher.launch(message["data"]["url"]);
        };
        break;
      case "zekr":
        buttonText = "ذهاب للصفحة";
        onButtonPressed = () async {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ZekrList(
                    category: message["data"]["category"],
                  )));
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
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            shadows: [
                              Shadow(
                                  blurRadius: 3.0,
                                  color: Colors.black,
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
    FileUtils.readFromFile().then((contents) {
      setState(() {
        fileContent = contents;
        if (fileContent.isNotEmpty) {
          var tempContent = fileContent.replaceRange(
              fileContent.length - 1, fileContent.length, '');
          favListItems = tempContent.split(',');
          favListItems.removeWhere((item) => item == '');
        }
        favListItems.removeWhere((item) => item == '');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height;
    var _screenWidth = MediaQuery.of(context).size.width;

    return Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
    BackgroundShapes(),
    SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
        endDrawer: Mesbaha(),
        drawerScrimColor: Theme.of(context).bottomAppBarColor,
        appBar: AppBar(
          title: Text(
            "الأذكار المفضلة",
            style: Theme.of(context)
                .appBarTheme
                .textTheme
                .headline
                .copyWith(fontSize: 14.0),
          ),
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[
            // _buildTestNtificationDialogue(),
            IconButton(
              padding: EdgeInsets.all(10.0),
              splashColor: Colors.red,
              highlightColor: Colors.red,
              tooltip: "حذف كل المفضلات",
              icon: Icon(
                Icons.delete_sweep,
                size: 25.0,
              ),
              onPressed: () {
                FileUtils.clearElements().whenComplete(() {
                  setState(() {
                    favListItems.clear();
                  });
                });
              },
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            ListView.builder(
                itemCount:
                    favListItems.isNotEmpty ? favListItems.length : 0,
                padding:
                    EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                              builder: (buildContext) => ZekrList(
                                    category: favListItems[index],
                                  )));
                    },
                    onLongPress: () async {},
                    child: Hero(
                      tag: '${favListItems[index]}',
                      child: favListItems.isNotEmpty
                          ? AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              margin: EdgeInsets.only(top: 8.0),
                              height: 50.0,
                              padding: EdgeInsets.only(right: 10.0),
                              // _screenWidth > _screenHeight
                              //     ? _screenHeight / 5.0 + 3.0
                              //     : _screenHeight / 10.0 + 3.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: index == 0
                                        ? Radius.circular(30.0)
                                        : Radius.circular(30.0),
                                    topRight: index == 0
                                        ? Radius.circular(30.0)
                                        : Radius.circular(30.0),
                                    bottomLeft:
                                        index == favListItems.length - 1
                                            ? Radius.circular(30.0)
                                            : Radius.circular(30.0),
                                    bottomRight:
                                        index == favListItems.length - 1
                                            ? Radius.circular(30.0)
                                            : Radius.circular(30.0),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 5.0,
                                        color: Colors.black45
                                            .withOpacity(0.45))
                                  ]),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 4.0,
                                ),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        favListItems[index],
                                        overflow: TextOverflow.fade,
                                        style: Theme.of(context)
                                            .appBarTheme
                                            .textTheme
                                            .body1,
                                        maxLines: 2,
                                        textDirection: TextDirection.rtl,
                                        softWrap: true,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                    _buildRemoveItemIconButton(
                                        context, index),
                                  ],
                                ),
                              )),
                            )
                          : Container(),
                    ),
                  );
                }),
            favListItems.isEmpty ? noItems(context) : Container()
          ],
        ),
      ),
    ),
        ],
      );
  }

  IconButton _buildTestNtificationDialogue() {
    return IconButton(
      icon: Icon(
        Icons.message,
      ),
      onPressed: () {
        firebaseMessagingHandlerTest();
      },
    );
  }

  Widget _buildRemoveItemIconButton(BuildContext context, int index) {
    return IconButton(
      tooltip: "حذف من المفضلة",
      icon: Icon(
        Icons.favorite_border,
        size: 25.0,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: AlertDialog(
                    titlePadding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    contentPadding: EdgeInsets.zero,
                    semanticLabel: "حذف من المفضلة",
                    title: Text(
                      "هل تريد حذف ${favListItems[index]} من القائمة ؟",
                      strutStyle: StrutStyle(
                        height: 2.0,
                        forceStrutHeight: true,
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "لا",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 12.0,
                              ),
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          FlatButton(
                            highlightColor: Colors.red,
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "نعم",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                              ),
                            ),
                            onPressed: () async {
                              await FileUtils.removeElement(favListItems[index])
                                  .whenComplete(() {
                                setState(() {
                                  favListItems.removeWhere(
                                      (item) => item == favListItems[index]);
                                });
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
      },
    );
  }
}

// this widget will appear if there is no items in favourite list
Widget noItems([BuildContext context]) {
  return Center(
      child: Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
    child: Text(
      "قائمة الأذكار المفضلة فارغة !\n",
      textScaleFactor: 1.1,
      strutStyle: StrutStyle(height: 1.5, forceStrutHeight: true),
      textAlign: TextAlign.center,
      style: Theme.of(context).appBarTheme.textTheme.headline.apply(
            fontSizeDelta: -4.0,
          ),
    ),
  ));
}

class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/favourites_list.txt');
  }

  static Future<File> saveToFile(String data) async {
    final file = await getFile;
    String fileContents = await readFromFile();
    var stringWithOutComma = fileContents;
    if (fileContents.isNotEmpty) {
      if (fileContents.endsWith(",")) {}

      var existingElements = stringWithOutComma.split(',');

      if (!existingElements.contains(data)) {
        print(data + " Added Successfully");
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("toggle", true);

        return file.writeAsString("$fileContents$data,");
      } else {
        print(data + " Removed Successfully");
        await removeElement(data);
        String c = await FileUtils.readFromFile();
        if (c.length < 2) {
          return await FileUtils.clearElements();
        }
      }
    } else {
      return file.writeAsString("$fileContents$data,");
    }
  }

  static Future<String> readFromFile() async {
    try {
      final file = await getFile;
      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      FileUtils.clearElements();
      return "";
    }
  }

  static Future<File> removeElement(String data) async {
    final file = await getFile;
    String fileContents = await file.readAsString();

    var stringWithOutComma = fileContents.replaceRange(
        fileContents.length - 1, fileContents.length, '');
    var existingElements = stringWithOutComma.split(',');
    int elementLocation;

    if (existingElements.contains(data)) {
      for (int index = 0; index < existingElements.length; index++) {
        if (existingElements[index] == data) {
          elementLocation = index;
          break;
        }
      }
    }
    existingElements.removeAt(elementLocation);
    var elementsStringWithComma = existingElements.join(",");
    await file.writeAsString(elementsStringWithComma + ",");
    if (await FileUtils.readFromFile() == "") {
      return await FileUtils.clearElements();
    } else {
      return await file.writeAsString(elementsStringWithComma + ",");
    }
  }

  static Future<File> clearElements() async {
    final file = await getFile;
    return file.writeAsString('');
  }
}

// A Class to Enable Notifications

class EnableNotifications {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/enable_notification.txt');
  }

  static Future<String> readFromFile() async {
    try {
      final file = await getFile;
      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      return "";
    }
  }

  static Future<File> enable() async {
    final file = await getFile;
    return file.writeAsString('1');
  }

  static Future<File> disable() async {
    final file = await getFile;
    return file.writeAsString('');
  }

  static Future<bool> isActive() async {
    final filecontent = await readFromFile();
    if (filecontent == "1") {
      return true;
    } else {
      return false;
    }
  }
}
