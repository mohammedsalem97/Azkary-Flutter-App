import 'package:azkar/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodayQuate extends StatefulWidget {
  @override
  _TodayQuateState createState() => _TodayQuateState();
}

class _TodayQuateState extends State<TodayQuate> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 5000)).whenComplete(() {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(
        builder: (BuildContext context) => HomeScreen(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
      type: MaterialType.transparency,
      child: Container(
        color: Color(0xfff59495),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  "assets/500px_logo_with_shadow.png",
                  height: 250,
                  width: 250.0,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  color: Colors.black.withOpacity(0.2),
                  child: Image.asset(
                    "assets/verse.png",
                    scale: 1.0,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
