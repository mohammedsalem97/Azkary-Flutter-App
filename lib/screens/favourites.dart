import 'dart:io';

import 'package:azkar/colors/colors.dart';
import 'package:azkar/screens/zekr_details.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';

import 'home_screen.dart';

final List<String> favouriteAzkar = [];

class FavouriteList extends StatefulWidget {
  @override
  _FavouriteListState createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  String fileContent = "";
  List<String> favListItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FileUtils.readFromFile().then((contents) {
      setState(() {
        fileContent = contents;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height;
    var _screenWidth = MediaQuery.of(context).size.width;
    if (fileContent.isNotEmpty) {
      var tempContent = fileContent.replaceRange(
          fileContent.length - 1, fileContent.length, '');
      favListItems = tempContent.split(',');
    }

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: darkColor1),
        ),
        //Container(color: Colors.black54.withOpacity(0.3)),
        Scaffold(
          endDrawer: Mesbaha(),
          drawerScrimColor: goldColor,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: goldColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: Shimmer(
              period: Duration(milliseconds: 1000),
              gradient: LinearGradient(colors: [goldColor, Color(0xffffd802)],),
              child: Text(
                "الأذكار المفضلة",
                style: TextStyle(fontSize: 22.0, color: goldColor),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[
              Tooltip(
                message: "حذف كل المفضلات",
                preferBelow: false,
                child: IconButton(
                  icon: Icon(
                    Icons.delete_sweep,
                    size: 30.0,
                    color: goldColor,
                  ),
                  onPressed: () {
                    setState(() {
                      FileUtils.clearElements();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FavouriteList()));
                      fileContent = '';
                    });
                  },
                ),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              ListView.builder(
                  itemCount: favListItems.isNotEmpty ? favListItems.length : 0,
                  padding:
                      EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(CupertinoPageRoute(
//                          settings: ,
                            builder: (buildContext) => ZekrList.fromFont(
                                  category: favListItems[index],
                                  font: 'Tajawal',
                                )));
                      },
                      child: favListItems.isNotEmpty
                          ? Container(
                              margin: EdgeInsets.only(top: 10.0),
                              height: _screenWidth > _screenHeight
                                  ? _screenHeight / 5.0 + 3.0
                                  : _screenHeight / 10.0 + 3.0,
                              decoration: BoxDecoration(
                                  color: goldColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: index == 0
                                        ? Radius.circular(20.0)
                                        : Radius.circular(1.0),
                                    topRight: index == 0
                                        ? Radius.circular(20.0)
                                        : Radius.circular(1.0),
                                    bottomLeft: index == favListItems.length - 1
                                        ? Radius.circular(20.0)
                                        : Radius.circular(1.0),
                                    bottomRight:
                                        index == favListItems.length - 1
                                            ? Radius.circular(20.0)
                                            : Radius.circular(1.0),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 5.0,
                                        color: goldColor.withOpacity(0.5))
                                  ]),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0, left: 8.0, right: 8.0),
                                child: Hero(
                                  tag: '${favListItems[index]}',
                                  child: Text(
                                    favListItems[index],
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        color: darkColor1,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.w700,),
                                    maxLines: 2,
                                    textDirection: TextDirection.rtl,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )),
                            )
                          : Container(),
                    );
                  }),
              favListItems.isEmpty ? noItems() : Container()
            ],
          ),
        ),
      ],
    );
  }
}

// this widget will appear if there is no items in favourite list
Widget noItems() {
  return Center(
      child: Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
    child: Text(
      "قائمة الأذكار المفضلة فارغة !\nلإضافة الأذكار إلى المفضلة اضغط مطولاً على عنوان هذا الذكر أو الدعاء",
      textScaleFactor: 1.2,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: goldColor,
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
