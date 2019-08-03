import 'package:azkar/screens/favourites.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:azkar/screens/home_screen.dart';
import 'colors/colors.dart';

void main() {
  runApp(OverlaySupport(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'أذكاري',
      theme: colorTheme,
      home: HomeScreen(),
    ),
  ));
}
