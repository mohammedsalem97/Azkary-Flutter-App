import 'package:azkar/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BackgroundShapes extends StatefulWidget {
  final isInsideZekrPage;
  BackgroundShapes({this.isInsideZekrPage = false});
  @override
  _BackgroundShapesState createState() => _BackgroundShapesState();
}

class _BackgroundShapesState extends State<BackgroundShapes> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ScopedModelDescendant<UserScopedModel>(
        builder: (context, child, model) {
      return Hero(
        tag: 'BackgroundShapes',
        child: Stack(
          children: <Widget>[
            Container(
              color: Color(0xFFFBEFEF),
            ),

            ///[Colored cutted Background Containers]
            AnimatedContainer(
              curve: Curves.easeInCubic,//tobeedited
              duration: Duration(milliseconds: 500),
              height: (model.userModel.isBrightMode && !widget.isInsideZekrPage)
                  ? screenHeight * 0.80
                  : screenHeight * 0.98,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Theme.of(context)
                        .primaryColor, // The Bright color of the theme
                    Theme.of(context)
                        .accentColor, // The dark color of the theme
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(
                      model.userModel.isBrightMode ? 250 : 50.0,
                      model.userModel.isBrightMode ? 160 : 10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.155),
                    offset: Offset(2.0, 8.0),
                    blurRadius: 5.0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    offset: Offset(5.0, 20.0),
                    blurRadius: 5.0,
                  ),
                ],
              ),
            ),

            ///[Overlayed container]

            Align(
              alignment: Alignment.topLeft,
              child: Opacity(
                opacity: 0.5,
                child: AnimatedContainer(
                  curve: Curves.easeInCubic,//tobeedited
                  duration: Duration(milliseconds: 500),
                  height:
                      (model.userModel.isBrightMode && !widget.isInsideZekrPage)
                          ? screenHeight * 0.80
                          : screenHeight * 0.98,
                  width:
                      model.userModel.isBrightMode ? screenWidth * 0.65 : 0.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.white
                            .withOpacity(0.0), // The Bright color of the theme
                        Colors.white
                            .withOpacity(0.5), // The dark color of the theme
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(250, 160),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
