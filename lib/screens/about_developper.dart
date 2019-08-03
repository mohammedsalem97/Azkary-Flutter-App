import 'package:azkar/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'home_screen.dart';

class AboutDeveloper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Shimmer(
          direction: ShimmerDirection.ttb,
          period: Duration(seconds: 10),
          gradient: RadialGradient(
            radius: 5.0,
            colors: [
              Color(0xffc6426e),
              Color(0xff642B73),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff642B73),
                Color(0xffc6426e),
              ], begin: Alignment.bottomCenter, end: Alignment.topRight),
            ),
          ),
        ),
        Hero(
          tag: 'developer info',
          child: Scaffold(
            endDrawer: Mesbaha(),
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                "عن المطـوِّر",
                textScaleFactor: 0.9,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                ),
              ],
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 15.0),
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
//                      Text(
//                        "ENG",
//                        style: TextStyle(
//                          fontSize: 16.0,
//                          color: Colors.white,
//                          fontFamily: 'Poppins',
//                          letterSpacing: 5.0
//                        ),
//                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Shimmer(
                        gradient: RadialGradient(
                            colors: [ Colors.white60,Colors.white,]),
                        child: Text(
                          "Mohammed Ahmed Salem",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.visible,

                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500),
                        ),
                      ),

                      Divider(
                        height: 15.0,
                        color: Colors.white,
                        indent: 40.0,
                        endIndent: 40.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Flutter Developer\n"
                        "UI Designer\n"
                        "Graphic Designer\n"
                        "Motion Graphic Designer\n"
                        "Web Designer\n"
                        "Freelancer\n"
                        "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            fontFamily: 'Poppins',
                            wordSpacing: 8.0,
                            letterSpacing: 2.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "E-mail",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3.0),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        "salemoon2@gmail.com",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            letterSpacing: 1.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
