import 'package:azkar/screens/islamyOnline/podcasts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class IslamicVideos extends StatefulWidget {
  @override
  _IslamicVideosState createState() => _IslamicVideosState();
}

class _IslamicVideosState extends State<IslamicVideos> {
  Future _videoFutureData;
  var _waitingOrTimeOut = stillLoading();
  @override
  void initState() {
    super.initState();
    _videoFutureData = _getVideos();
  }

  /// A Method to [get] and [serialize] Json data comming from the firebase database
  Future<List<Video>> _getVideos() async {
    var data =
        await http.get("https://azkary-app-c8f2b.firebaseio.com/videos.json");
    Map<String, dynamic> jsonData = json.decode(data.body);
    List<Video> _videos = [];
    jsonData.forEach((String videoId, videoData) {
      Video video = Video(
          videoData['title'], videoData['url'], videoData['thumnailImage'],
          presenter: videoData['presenter']);
      _videos.add(video);
    });
    print("${jsonData.length} videos found");
    await Future.delayed(Duration(seconds: 2)).whenComplete(() {});
    return _videos;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _videoFutureData,
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text(
              'none',
              style: TextStyle(color: Colors.black),
            );
          case ConnectionState.waiting:
            Future.delayed(Duration(seconds: 10)).whenComplete(() {
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
            return _buildListViewPlaceholder(snapshot.data);

          default:
            return errorOccured();
        }
      },
    );
  }
}

class Video {
  final String title;
  final String url;
  final String thumnailImage;
  final String presenter;
  Video(this.title, this.url, this.thumnailImage, {this.presenter = null});
}

/// * A ListView Widget to build the results of HTTP Request for [Videos]
Widget _buildListViewPlaceholder(List<Video> videosList) {
  return Container(
    child: ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      itemCount: videosList.length,
      itemBuilder: (context, index) {
        var _color = getRandomColor();
        return InkWell(
          onTap: () async {
            if (await canLaunch(videosList[index].url)) {
              launch(
                videosList[index].url,
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: _color,
                          image: DecorationImage(
                            image: NetworkImage(
                              videosList[index].thumnailImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        // color: Theme.of(context).primaryColor,
                        alignment: Alignment.center,
                      ),
                      Icon(
                        Icons.play_circle_outline,
                        color: Colors.white.withOpacity(0.7),
                        size: 55.0,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    videosList[index].title,
                    style: Theme.of(context)
                        .appBarTheme
                        .textTheme
                        .headline
                        .copyWith(
                            color: Colors.black,
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: videosList[index].presenter != null
                      ? Text(
                          videosList[index].presenter,
                          style: Theme.of(context)
                              .appBarTheme
                              .textTheme
                              .headline
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.normal),
                        )
                      : Container(),
                  leading: IconButton(
                    icon: Icon(
                      Icons.play_arrow,
                      size: 25.0,
                      color: _color,
                    ),
                    onPressed: () async {
                      if (await canLaunch(videosList[index].url)) {
                        launch(videosList[index].url);
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
                      Share.share(videosList[index].url);
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
