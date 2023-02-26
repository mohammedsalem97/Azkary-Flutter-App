import 'package:azkar/screens/zekr_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ZekrTitle extends StatefulWidget {
  final List<String> finalCategoryList;

  ZekrTitle(this.finalCategoryList);

  @override
  _ZekrTitleState createState() => _ZekrTitleState();
}

class _ZekrTitleState extends State<ZekrTitle> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return ListView.builder(
      itemCount: this.widget.finalCategoryList.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: InkWell(
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: this.widget.finalCategoryList[index],
                    child: Container(
                      margin: EdgeInsets.only(bottom: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: index == 0
                              ? Radius.circular(50.0)
                              : Radius.circular(15.0),
                          topRight: index == 0
                              ? Radius.circular(50.0)
                              : Radius.circular(15.0),
                          bottomLeft:
                              index == widget.finalCategoryList.length - 1
                                  ? Radius.circular(50.0)
                                  : Radius.circular(15.0),
                          bottomRight:
                              index == widget.finalCategoryList.length - 1
                                  ? Radius.circular(50.0)
                                  : Radius.circular(15.0),
                        ),
                        color: Theme.of(context).cardColor,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                              color: Colors.black45.withOpacity(0.45))
                        ],
                      ),
                      width: _screenWidth,
                      height: 45.0,
                      child: Center(
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            widget.finalCategoryList[index],
                            style: Theme.of(context).textTheme.body1,
                            maxLines: 2,
                            textDirection: TextDirection.rtl,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (buildContext) => ZekrList(
                      category: widget.finalCategoryList[index],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
