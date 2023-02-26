import 'package:azkar/screens/islamyOnline/podcasts.dart';
import 'package:flutter/material.dart';

import 'videosIslamic.dart';

class IslamyOnline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'islamyOnline',
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: Text(
              " إسلامي أونلاين",
              style: Theme.of(context)
                  .appBarTheme
                  .textTheme
                  .headline
                  .copyWith(fontSize: 12.0),
            ),
            actions: <Widget>[
              Icon(
                Icons.language,
                size: 22.0,
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
            backgroundColor: Color(0xff721264),
            bottom: TabBar(
                // isScrollable: true,
                indicatorColor: Colors.white,
                labelStyle: Theme.of(context)
                    .appBarTheme
                    .textTheme
                    .headline
                    .copyWith(fontSize: 10.0),
                labelColor: Colors.white,
                labelPadding: EdgeInsets.zero,
                unselectedLabelColor: Colors.white.withOpacity(0.5),
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.ondemand_video,
                      size: 20.0,
                    ),
                    text: "فيديو",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.radio,
                      size: 20.0,
                    ),
                    text: "بودكاست",
                  ),
                ]),
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              IslamicVideos(),
              PodCasts(),
            ],
          ),
        ),
      ),
    );
  }
}
