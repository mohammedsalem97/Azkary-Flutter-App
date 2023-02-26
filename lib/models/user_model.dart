import 'package:azkar/screens/prayertimes.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

///tobeedited
///[1-add new font to sharedPreferences when it's changed]

class UserModel {
  bool isBrightMode = true;
  List<String> fonts = ["GESS", "FJ", "AMaster", "DefaultFont"];
  String currentFont = "GESS";
  bool isLoading = true;
}

class UserScopedModel extends Model {
  UserModel userModel = UserModel();

  //int index = 0;
  Future get getindex async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var savedFont = prefs.getString("font");
    if (savedFont != null) {
      index = userModel.fonts.indexOf(savedFont);
      userModel.currentFont = userModel.fonts[index];
      notifyListeners();
      return index;
    } else {
      index = 0;
      userModel.currentFont = userModel.fonts[index];
      notifyListeners();
      return index;
    }
  }

  var index;

  void switchTheme() async {
    userModel.isBrightMode = !userModel.isBrightMode;
    prayerCardTheme = userModel.isBrightMode
        ? {"bgColor": Colors.white, "textColor": Colors.black}
        : {"bgColor": Color(0xFF063A4A), "textColor": Colors.white};
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', userModel.isBrightMode);
    print("bright mode is ${userModel.isBrightMode} and saved !");
    notifyListeners();
  }

  ///[PUT USERMODEL .IS BRRIGHT ?? IN THE SART OF THE APP]
  Future autoTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var themeStatus = prefs.getBool('theme');
    var favFont = prefs.getString('font');

    if (themeStatus == null) {
      userModel.isBrightMode = true;
      prefs.setBool('theme', true);
      prayerCardTheme = {"bgColor": Colors.white, "textColor": Colors.black};
      notifyListeners();
      print("i have no preferences !");
    } else {
      userModel.isBrightMode = themeStatus;
      prayerCardTheme = userModel.isBrightMode
          ? {"bgColor": Colors.white, "textColor": Colors.black}
          : {"bgColor": Color(0xFF063A4A), "textColor": Colors.white};
      notifyListeners();
      print("App was shipped with isBright = $themeStatus");
    }
    if (favFont != null) {
      userModel.currentFont = favFont;
      notifyListeners();
    }
    //  else {
    //   notifyListeners();
    // }

    userModel.isLoading = false;
    notifyListeners();
  }

  void switchFont() async {
    index = await getindex;
    print("Font index now is:" +
        index.toString() +
        " before switching from switchFont<<<<<<<<<<<<<<<<<<<<<");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await index <= 2) {
      index++;
      userModel.currentFont = userModel.fonts[index];

      prefs.setString("font", userModel.currentFont);
      notifyListeners();
      print(
          "current font Now is '${userModel.currentFont} and index is $index'");
    } else {
      index = 0;
      notifyListeners();
      userModel.currentFont = userModel.fonts[index];
      prefs.setString("font", userModel.currentFont);
      notifyListeners();
      print(
          "current font Now is '${userModel.currentFont} and index is $index");
    }
  }
}
