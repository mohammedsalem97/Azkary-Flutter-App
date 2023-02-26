import 'dart:math';

import 'package:azkar/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SwitchThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserScopedModel>(
        builder: (context, child, model) {
      return CircleAvatar(
        backgroundColor:
            Theme.of(context).accentColor.withRed(1200).withOpacity(0.5),
        child: IconButton(
          onPressed: () {
            model.switchTheme();
          },
          icon: Transform.rotate(
            angle: 145 * (pi / 180),
            child: Icon(
              model.userModel.isBrightMode
                  ? Icons.brightness_3
                  : Icons.brightness_7,
              size: 24.0,
            ),
          ),
          tooltip: "الوضع الليلي",
        ),
      );
    });
  }
}
