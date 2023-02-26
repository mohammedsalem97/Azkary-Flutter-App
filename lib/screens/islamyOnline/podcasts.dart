import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class PodCasts extends StatefulWidget {
  @override
  _PodCastsState createState() => _PodCastsState();
}

class _PodCastsState extends State<PodCasts> {
  Future _podcastFutureData;
  var _waitingOrTimeOut = stillLoading();

  @override
  void initState() {
    _podcastFutureData = _getPodcasts();
    super.initState();
  }

  /// A Method to [get] and [serialize] Json data comming from the firebase database
  Future<List<Podcast>> _getPodcasts() async {
    var data =
        await http.get("https://azkary-app-c8f2b.firebaseio.com/podcasts.json");
    Map<String, dynamic> jsonData = json.decode(data.body);
    List<Podcast> _podcasts = [];
    jsonData.forEach((String podcastId, podcastData) {
      Podcast podcast = Podcast(podcastData['title'], podcastData['url']);
      _podcasts.add(podcast);
    });
    print("${jsonData.length} podcasts found");
    await Future.delayed(Duration(seconds: 1)).whenComplete(() {});
    return _podcasts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _podcastFutureData,
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text(
              'none',
              style: TextStyle(color: Colors.black),
            );
          case ConnectionState.waiting:
            Future.delayed(Duration(seconds: 3)).whenComplete(() {
              if (snapshot.connectionState != ConnectionState.done) {
                if (mounted) {
                  setState(() {
                    _waitingOrTimeOut = errorFetchingData();
                  });
                }
              }
            });
            return Center(child: _waitingOrTimeOut);

          //return Text('waiting',style: TextStyle(color: Colors.black));
          case ConnectionState.done:
            if (snapshot.data == null) {
              return errorFetchingData();
            }
            return buildListViewPlaceholder(snapshot.data);

          default:
            return errorOccured();
        }
      },
    );
  }

  ///A ListView Widget to build the results of HTTP Request for [Podcasts]
  Widget buildListViewPlaceholder(List<Podcast> podcastsList) {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 5.0),
        itemCount: podcastsList.length,
        itemBuilder: (context, index) {
          var _color = getRandomColor();
          return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () async {
              if (await canLaunch(podcastsList[index].url)) {
                launch(
                  podcastsList[index].url,
                );
              }
            },
            child: Card(
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 3.0,
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        color: _color,
                        // color: Theme.of(context).primaryColor,
                        alignment: Alignment.center,
                      ),
                      Icon(
                        Icons.radio,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text(
                      podcastsList[index].title,
                      style: Theme.of(context)
                          .appBarTheme
                          .textTheme
                          .headline
                          .copyWith(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: IconButton(
                      icon: Icon(
                        Icons.headset,
                        size: 25.0,
                        color: _color,
                      ),
                      onPressed: () async {
                        if (await canLaunch(podcastsList[index].url)) {
                          launch(podcastsList[index].url);
                        }
                      },
                    ),
                    trailing: IconButton(
                      highlightColor: Colors.transparent,
                      icon: Icon(
                        Icons.share,
                        size: 20.0,
                        color: _color,
                      ),
                      onPressed: () async {
                        Share.share(podcastsList[index].url);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Podcast {
  final String title;
  final String url;
  Podcast(this.title, this.url);
}

//These Methods are used in many files:

/// A Method to obtain a Random color for :
/// * Card backgroundColor
/// * ListTile Leading Icon color
/// * The Loading [CircularProgressIndicator] color

Color getRandomColor() {
  List<Color> _colors = [
    Color(0xffFE4362),
    Color(0xff84AF9B),
    Color(0xffFFCCAD),
    Color(0xff721264),
  ];
  var _randomIndex = Random().nextInt(_colors.length);
  return _colors[_randomIndex];
}

/// * A method that returns a CicularProgressIndicator indicating that
///[Data is still being Loaded]
Widget stillLoading() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          backgroundColor: getRandomColor(),
          strokeWidth: 50.0,
        ),
        SizedBox(
          height: 30.0,
        ),
        Text("جارٍ التحميل", style: TextStyle(color: Color(0xff721264))),
      ],
    ),
  );
}

/// * A Widget that Appears when [No Data] fetched
Widget errorFetchingData() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.signal_wifi_off,
          size: 120.0,
          color: Color(0xff721264),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text("تأكد من اتصالك بالإنترنت",
            style: TextStyle(color: Color(0xff721264))),
      ],
    ),
  );
}

/// * A Method returns a Error Occured when fetching data
Widget errorOccured() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(
        Icons.error_outline,
        size: 70.0,
        color: Color(0xff721264),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text("حدث خطأ يُرجى المحاولة لاحقاً",
          style: TextStyle(color: Color(0xff721264))),
    ],
  ));
}
