import 'dart:math';

import 'package:azkar/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class RoundClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: min(size.width, size.height) / 2);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class Fab extends StatelessWidget {
  final Widget child;
  final String message;
  final Function onpressed;
  final double elevation;
  const Fab(
      {@required this.child,
      @required this.onpressed,
      @required this.message = '',
      this.elevation = 6.0});
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserScopedModel>(
        builder: (context, childmodel, model) {
      return Tooltip(
        message: this.message,
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(10.0),
        child: Material(
          elevation: elevation,
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100.0),
          child: ClipOval(
            clipper: RoundClipper(),
            child: Material(
              child: InkWell(
                onTap: onpressed,

                //sssss
                child: Container(
                  height: 56.0,
                  width: 56.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        model.userModel.isBrightMode
                            ? Theme.of(context).primaryColor
                            : Color(0xff4792AD),
                        model.userModel.isBrightMode
                            ? Theme.of(context).accentColor
                            : Color(0xff4792AD),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Center(
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
