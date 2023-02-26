import 'package:azkar/screens/zekr_details.dart';
import 'package:flutter/material.dart';

class AzkarSearch extends SearchDelegate<String> {
  List recentAzkar = [
    "دعاء السفر",
    "كيف يلبي المحرم في الحج أو العمرة ؟",
    "الرُّقية الشرعية من القرآن الكريم",
  ];

  final List<String> fullAzkarList;
  AzkarSearch({this.fullAzkarList}) {
    print("search is now !");
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isNotEmpty
          ? IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {
                query = '';
              },
            )
          : Container(),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back,color: Colors.white,),
      onPressed: () {
        close(context, null);
        //SystemChrome.setEnabledSystemUIOverlays([]);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults after selecting the corresponding Zekr search result
    //SystemChrome.setEnabledSystemUIOverlays([]);
    final List suggestedAzker = query.isEmpty
        ? recentAzkar
        : this
            .fullAzkarList
            .where((String item) => item.contains(query))
            .toList();
    return SafeArea(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 20.0),
        physics: BouncingScrollPhysics(),
        itemCount: suggestedAzker.length,
        itemBuilder: (context, index) {
          return Hero(
            tag: "${suggestedAzker[index]}",
            child: Container(
              color: index.isEven
                  ? Colors.grey.withOpacity(0.1)
                  : Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    dense: true,
                    title: Text(
                      suggestedAzker[index],
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    leading: Icon(
                      Icons.open_in_new,
                      size: 30.0,
                      color: Theme.of(context).accentColor,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ZekrList(
                                category: suggestedAzker[index],
                              )));
                      //SystemChrome.setEnabledSystemUIOverlays([]);
                    },
                  ),
                  Divider(
                    thickness: 2.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    final List suggestedAzker = query.isEmpty
        ? recentAzkar
        : this
            .fullAzkarList
            .where((String item) => item.contains(query))
            .toList();
    return SafeArea(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 20.0),
        physics: BouncingScrollPhysics(),
        itemCount: suggestedAzker.length,
        itemBuilder: (context, index) {
          return Container(
            color: index.isEven
                ? Colors.grey.withOpacity(0.1)
                : Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  dense: true,
                  title: Text(
                    suggestedAzker[index],
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  leading: Icon(
                    Icons.open_in_new,
                    size: 22.0,
                    color: Theme.of(context).accentColor.withOpacity(0.85),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ZekrList(
                              category: suggestedAzker[index],
                            )));
                    //SystemChrome.setEnabledSystemUIOverlays([]);
                  },
                ),
                Divider(
                  thickness: 1.0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
