import 'package:azkar/colors/colors.dart';
import 'package:azkar/screens/zekr_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///  ZekrTitle(zekrList[index].category));
///
///

class ZekrTitle extends StatelessWidget {
  //final List<ZekrObject> azkarList;
  final List<String> finalCategoryList;

  ZekrTitle(this.finalCategoryList);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Padding(
        padding: const EdgeInsets.only(
          top: 15.0,
        ),
        child: ListView.builder(
            padding: EdgeInsets.only(bottom: 10.0),
            itemCount: this.finalCategoryList.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Center(
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: GestureDetector(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: index == 0
                                        ? Radius.circular(20.0)
                                        : Radius.circular(5.0),
                                    topRight: index == 0
                                        ? Radius.circular(20.0)
                                        : Radius.circular(5.0),
                                    bottomLeft:
                                        index == finalCategoryList.length - 1
                                            ? Radius.circular(20.0)
                                            : Radius.circular(5.0),
                                    bottomRight:
                                        index == finalCategoryList.length - 1
                                            ? Radius.circular(20.0)
                                            : Radius.circular(5.0),
                                  ),
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 5.0,
                                        color: Colors.black45.withOpacity(0.5))
                                  ]),
                              width: _screenWidth,
                              height: _screenWidth > _screenHeight
                                  ? _screenHeight / 5.0 + 3.0
                                  : _screenHeight / 10.0 + 3.0,
                              child: Center(
                                child: Hero(
                                  tag: this.finalCategoryList[index],
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text(
                                      finalCategoryList[index],
                                      style: TextStyle(
                                          color: darkColor1,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 2,
                                      textDirection: TextDirection.rtl,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  transitionOnUserGestures: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (buildContext) => ZekrList.fromFont(
                                    category: finalCategoryList[index],
                                    font: 'Tajawal',
                                  )));
                        },
                      )));
            }));
  }
}
