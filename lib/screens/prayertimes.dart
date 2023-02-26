import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geopoint_location/geopoint_location.dart' as GeoPoint;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

var prayerCardTheme;

///TASKS FOR TODAY
///++++++[-1-]CALCULATE THE DIFFERENCE BETWEEN NOW AND THE NEXT PRAYER TIME

List<String> _prayerNames = [
  "الفجر",
  "الشروق",
  "الظهر",
  "العصر",
  "المغرب",
  "العشاء",
  "منتصف الليل"
];

class PrayerTimes extends StatefulWidget {
  @override
  _PrayerTimesState createState() => _PrayerTimesState();
}

class _PrayerTimesState extends State<PrayerTimes> {
  PryerTimesCalc prayerObject = PryerTimesCalc();

  List<String> _nearTimes = [
    "04:20",
    "05:40",
    "12:59",
    "15:32",
    "18:18",
    "19:37",
  ];

  TextStyle _upcommingPrayerTextStyle = TextStyle(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold);
  //DateTime _now=DateTime.parse("T00:10");
  var myList;
  Timer _myTimer;

  @override
  void initState() {
    _myTimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FutureBuilder(
          future: prayerObject.getPrayerTimes(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              var _nextPrayer =
                  prayerObject.getNextPrayer(snapshot.data, _prayerNames);
              return Stack(
                children: <Widget>[
                  Opacity(
                    opacity: 0.3,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/prayer_bg_small.png"),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black, BlendMode.overlay)),
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 150.0, sigmaY: 150.0),
                    child: Container(),
                  ),
                  OrientationBuilder(builder: (context, orientation) {
                    if (orientation == Orientation.portrait) {
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).padding.top,
                          ),
                          buildMainPrayerBanner(_nextPrayer,
                              screenShare: 1 / 3),
                          for (int i = 0; i < snapshot.data.length; i++)
                            buildPrayerCard(i, _nextPrayer, context, snapshot,
                                verticalMargin: 2.5),
                        ],
                      );
                    } else {
                      //Landscape view
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).padding.top,
                          ),
                          buildMainPrayerBanner(_nextPrayer,
                              screenShare: 1 / 2),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    //first column
                                    child: Column(
                                      children: <Widget>[
                                        for (var a in [0, 2, 4])
                                          buildPrayerCard(
                                              a, _nextPrayer, context, snapshot,
                                              verticalMargin: 3.0),
                                      ],
                                    ),
                                  ),
                                ),
                                //Odd prayers indics
                                Expanded(
                                  child: Container(
                                    //first column
                                    child: Column(
                                      children: <Widget>[
                                        for (var a in [1, 3, 5])
                                          buildPrayerCard(
                                              a, _nextPrayer, context, snapshot,
                                              verticalMargin: 3.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  })
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildMainPrayerBanner(_nextPrayer, {double screenShare = 0.25}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1 / 3,
      child: Card(
        margin: EdgeInsets.only(top: 0.0, bottom: 2.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFCB92), Colors.orange],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/prayer_bg_small.png"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.multiply)),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Spacer(flex: 3,),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _nextPrayer["name"],
                          style: TextStyle(
                            color: Color(0xFFFFCB92),
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  color: Colors.black.withOpacity(0.6),
                                  offset: Offset(0.5, 1.0),
                                  blurRadius: 10.0),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            get12hFormat(_nextPrayer["atTime"]),
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 1),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      _nextPrayer["details"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(0.5, 1.5),
                              blurRadius: 3.0),
                        ],
                      ),
                    ),
                  ),
                  Spacer(flex: 3),
                ],
              ),
            ),
            Positioned(
              bottom: 7.0,
              right: 8.0,
              child: FutureBuilder(
                future: prayerObject.getCords(),
                builder: (context, locationData) {
                  if (locationData.data != null) {
                    return Text(
                      "${locationData.data[3]}",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 8.0,
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 0.0,
                      width: 0.0,
                    );
                  }
                },
              ),
            ),
            Positioned(
              top: -5.0,
              right: -5.0,
              child: IconButton(
                icon: Icon(
                  Icons.location_on,
                  size: 24.0,
                  color: Colors.grey,
                ),
                tooltip: "تحديث الموقع",
                onPressed: () async {
                  var geoPoint = await GeoPoint.geoPointFromLocation(
                      name: "Current position", withAddress: true);
                  try {
                    SharedPreferences _myPrefs =
                        await SharedPreferences.getInstance();
                    _myPrefs.setString(
                        "_locality", geoPoint.locality.toString());
                    _myPrefs.setDouble("long", geoPoint.longitude);
                    _myPrefs.setDouble("lat", geoPoint.latitude);
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///* Method to build prayer card like [Fajr           4:45 AM]
  Widget buildPrayerCard(
      int i, _nextPrayer, BuildContext context, AsyncSnapshot snapshot,
      {double verticalMargin = 3.0}) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: verticalMargin),
        elevation: i == _nextPrayer["prayerIndex"] ? 10.0 : 6.0,
        color: i == _nextPrayer["prayerIndex"]
            ? Colors.orange[200]
            : prayerCardTheme["bgColor"],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //prayer name
              Text(
                _prayerNames[i],
                style: i == _nextPrayer["prayerIndex"]
                    ? _upcommingPrayerTextStyle
                    : _upcommingPrayerTextStyle.apply(
                        color: prayerCardTheme["textColor"]),
              ),
              //prayer time
              Text(
                get12hFormat(snapshot.data[i]),
                style: i == _nextPrayer["prayerIndex"]
                    ? _upcommingPrayerTextStyle
                    : _upcommingPrayerTextStyle.apply(
                        color: prayerCardTheme["textColor"]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///* PrayerTime class which contains calculations and helper functions to calculate and format the prayer times
class PryerTimesCalc {
  PryerTimesCalc() {
    print("PrayerTimes class initialized ");
  }

  bool doneNotified = false;
  int oldIndex = -1;

  Future<List<dynamic>> getCords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final long = prefs.getDouble("long");
    final lat = prefs.getDouble("lat");
    final locality = prefs.getString("_locality");
    final zoneOffset = DateTime.now().timeZoneOffset.inHours;
    var tt = DateTime.now().timeZoneOffset.inHours;

    if (long == null || lat == null || locality == null) {
      return [31.233334, 30.033333, 2.0, "القاهرة"];
    } else {
      return [long, lat, zoneOffset, locality];
    }
  }

  ///* Method returns a list of prayer times strings formated as hh:mm for ex. [22:12]
  Future<List<String>> getPrayerTimes() async {
    var _currentTime = DateTime.now();
    var _year = _currentTime.year;
    var _month = _currentTime.month;
    var _day = _currentTime.day;

    ///[CO-ORDINATIONS OF THUSER PLACE AND THE TIME ZONE OFFSET]
    var _cordsList = await getCords();
    var Long = _cordsList[0];
    var Lat = _cordsList[1];
    var Zone = _cordsList[2];

    ///Calculations starts here
    var jd = julianDate(_year, _month, _day);
    var d = jd - 2451545.0; // jd is the given Julian date
    var g = (357.529 + 0.98560028 * d);
    var q = 280.459 + 0.98564736 * d;
    var L = q + (1.915 * sind(g) + 0.020 * sind(2 * g));
    var R = 1.00014 - 0.01671 * cosd(g) - 0.00014 * cosd(2 * g);
    var e = 23.439 - 0.00000036 * d;
    var RA = atand(cosd(e) * sind(L) / cosd(L)) / 15;
    var EqT = q / 15 - RA;
    var D = asind(sind(e) * sind(L)); // declination of the Sun

    var Dhuhr = 12 + Zone - Long / 15 - EqT;

    var Sunrise = Dhuhr - T(0.833, Lat, D);

    var Sunset = Dhuhr + T(0.833, Lat, D);

    var Maghrib = Dhuhr + T(4, Lat, D);

    var Fajr = Dhuhr - T(19.5, Lat, D);

    var Isha = Dhuhr + T(17.5, Lat, D);

    var Asr = Dhuhr + A(1, Lat, D);

    var Midnight = Sunset + (Sunset - Sunrise) / 2;

    // return [
    //   "00:51",
    //   "13:21",
    //   "13:22",

    //   //ttttttttttttttttt
    //   "13:59",
    //   "22:37",
    //   "23:18",
    // ];
    return [
      getTimeFormat(Fajr),
      getTimeFormat(Sunrise),
      getTimeFormat(Dhuhr),
      getTimeFormat(Asr),
      getTimeFormat(Sunset),
      getTimeFormat(Isha),
    ];
  }

  ///Method returns
  ///* Next prayer name
  ///* Next prayer Time
  ///* Remaining duration to the next prayer formatted
  getNextPrayer(List<String> rawTimes, List<String> prayerNames) {
    List<DateTime> actualTimes = [];
    for (var el in rawTimes) {
      actualTimes.add(DateTime.parse(
          "${DateTime.now().toIso8601String().split("T")[0] + "T" + el}"));
    }

    Duration minDiff = null;
    int prayerIndex = 0;
    for (var t in actualTimes) {
      if (t.isAfter(DateTime.now())) {
        minDiff = t.difference(
            DateTime.now()); //now we got the next prayer remaining time
        break;
      }
      prayerIndex++;
    }
    List<Time> notificationTimes = [];
    for (var stringTime in rawTimes) {
      notificationTimes.add(Time(int.parse(stringTime.substring(0, 2)),
          int.parse(stringTime.substring(3, 5))));
    }
    if (oldIndex != prayerIndex) {
      doneNotified = false;
    }
    if (minDiff != null) {
      if (minDiff.inMinutes == 0 && !doneNotified) {
        // showNotification3(
        //     notification: notification,
        //     channelId: 4,
        //     title: prayerNames[prayerIndex], //"أذكار النوم",
        //     time: Time(23, 0, 0));
        // doneNotified = !doneNotified;
        // print("Now Nonotifications for ${prayerNames[prayerIndex]}");
      }
    }
    oldIndex = prayerIndex;
    if (minDiff == null) {
      var midnight = DateTime.parse(
          "${DateTime.now().add(Duration(days: 1)).toIso8601String().split("T")[0] + "T" + "00:00:00"}");
      minDiff = midnight.difference(DateTime.now());
    }
    var textRemains;
    if (minDiff.inSeconds <= 30) {
      textRemains = " الآن ";
    } else {
      textRemains = ((minDiff.inMinutes == 0 && minDiff.inHours == 0)
              ? "" //" الآن "
              : " المتبقي ") +
          ((minDiff.inHours > 10) ? "${minDiff.inHours}" + " ساعة " : "") +
          ((minDiff.inHours < 11 &&
                  minDiff.inHours > 2 &&
                  ((minDiff.inMinutes + 1) % 60) != 0)
              ? "${minDiff.inHours}" + " ساعات "
              : "") +
          ((minDiff.inHours > 10) ? "${minDiff.inHours}" + " ساعة " : "") +
          ((minDiff.inHours < 11 &&
                  minDiff.inHours > 1 &&
                  ((minDiff.inMinutes +1) % 60) == 0)
              ? "${minDiff.inHours + 1}" + " ساعات "
              : "") + //dddddddddddd
          ((minDiff.inMinutes > 118 && minDiff.inMinutes < 179)
          //((minDiff.inHours == 2 && minDiff.inMinutes > 119)
              ? " ساعتان "
              : "") +
          ((minDiff.inMinutes < 119 && minDiff.inMinutes > 58)
              ? " ساعة واحدة "
              : "") +
          ((((minDiff.inMinutes + 1) % 60) != 0 && minDiff.inHours > 0)
              ? "و "
              : "") +
          ((((minDiff.inMinutes) % 60) > 10 &&
                  ((minDiff.inMinutes + 1) % 60) != 0)
              ? "${(minDiff.inMinutes + 1) % 60}" + " دقيقة "
              : "") + //ddddddddddddddddddd
          ((((minDiff.inMinutes) % 60) < 11 && ((minDiff.inMinutes) % 60) > 1)
              ? "${(minDiff.inMinutes + 1) % 60}" + " دقائق "
              : "") +
          ((((minDiff.inMinutes) % 60) == 1) ? " دقيقتان " : "") +
          ((((minDiff.inMinutes) % 60) == 0) ? " دقيقة واحدة " : "");
    }

    return {
      "name": prayerNames[prayerIndex], //nnnnnn
      "atTime": DateTime.now()
          .add(minDiff)
          .toIso8601String()
          .split("T")[1]
          .substring(0, 5),
      "details": textRemains,
      "prayerIndex": prayerIndex,
    };
  }
}

///* [HELPER FUNCTOINS]//////////////////////////////
double sind(angle) {
  return sin(angle * pi / 180);
}

double cosd(double angle) {
  return cos(angle * pi / 180);
}

double tand(double angle) {
  return tan(angle * pi / 180);
}

double asind(double angle) {
  return asin(angle) * 180 / pi;
}

double acosd(double angle) {
  return acos(angle) * 180 / pi;
}

double atand(double angle) {
  return atan(angle) * 180 / pi;
}

///* A method that returns a formatted representation for the time hh:mm
getTimeFormat(double unformatedTime) {
  unformatedTime %= 24;
  var hours = unformatedTime.truncate();
  var minutes = ((unformatedTime - unformatedTime.truncate()) * 60).round();

  if (minutes == 60) {
    hours += 1;
    minutes = 0;
  }
  if (hours == 24) {
    hours = 0;
    minutes = 0;
  }
  var adjhours = hours.toString();
  var adjminutes = minutes.toString();

  if (adjminutes.length < 2) {
    adjminutes = '0' + adjminutes;
  }
  if (adjhours.length < 2) {
    adjhours = '0' + adjhours;
  }

  return adjhours + ':' + adjminutes;
}

///* Method to convert time to 12h format
String get12hFormat(String time) {
  var minutes = time.substring(3, 5);
  var hours = int.parse(time.substring(0, 2));
  var am_pm = hours > 12 ? "م" : "ص";
  var newHours =
      hours < 12 ? hours.toString() : ((hours + 12 - 1) % 12 + 1).toString();
  return "$newHours" + ":" + "$minutes" + " $am_pm";
}

///* Method converts day to julian day
julianDate(year, month, day) {
  if (month <= 2) {
    year -= 1;
    month += 12;
  }

  var A = (year / 100).floor();
  var B = 2 - A + (A / 4).floor();

  var JD = (365.25 * (year + 4716)).floor() +
      (30.6001 * (month + 1)).floor() +
      day +
      B -
      1524.5;
  return JD;
}

//////////////////////////////////////////////////
T(alpha, l, d) {
  var t = (1 / 15) *
      acosd((-sind(alpha) - sind(l) * sind(d)) / (cosd(l) * cosd(d)));
  return t;
}

A(t, l, d) {
  var a = (1 / 15) *
      acosd((sind(atand(1 / (t + tand(l - d)))) - sind(l) * sind(d)) /
          (cosd(l) * cosd(d)));
  return a;
}
