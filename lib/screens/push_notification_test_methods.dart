import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'dart:math' as math;

/// * A function to fire the local daily notifications
Future showNotification3({
  @required final FlutterLocalNotificationsPlugin notification,
  @required final int channelId,
  @required final String title,
  String body,
  @required final Time time,
}) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    channelId.toString(),
    'show weekly channel $title',
    'show weekly description',
    priority: Priority.Max,
    color:
        Color((math.Random().nextDouble() * 0xffffff).toInt()).withOpacity(1.0),
    largeIconBitmapSource: BitmapSource.Drawable,
    largeIcon: "large_icon",
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  body = title;
  await notification.showDailyAtTime(channelId, title,
      "حان الآن وقت قراءة $body", time, platformChannelSpecifics,
      payload: title);
  debugPrint(">>>>>>><<<<<< I am from $title channel >>>>>><<<<<<");
}
