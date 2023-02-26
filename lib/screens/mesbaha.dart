import 'package:flutter/material.dart';

class Mesbaha extends StatefulWidget {
  @override
  _MesbahaState createState() => _MesbahaState();
}

class _MesbahaState extends State<Mesbaha> with SingleTickerProviderStateMixin {
  int _counter = 0;
  Color _counterColor = Color(0xFF0E262E); //the accent color of the dark theme
  Color _counterNumberColor = Colors.white.withOpacity(0.8);

  AnimationController _slideController;
  Animation _animation;

  @override
  void initState() {
    _slideController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<Offset>(begin: Offset(0, 20), end: Offset.zero).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    super.initState();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.topCenter,
      overflow: Overflow.visible,
      children: <Widget>[
        Scaffold(
          primary: true,
          backgroundColor: _counterColor,
          appBar: AppBar(
            actions: <Widget>[
              Icon(
                Icons.donut_large,
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
            elevation: 0.0,
            title: Text(
              "المسـبـحة",
              style: Theme.of(context)
                  .appBarTheme
                  .textTheme
                  .headline
                  .copyWith(fontSize: 14.0),
              maxLines: 2,
            ),
            centerTitle: true,
          ),
          body: InkWell(
            onTap: () {
              setState(() {
                _counter++;
                if (_counter == 1) {
                  setState(() {
                    _slideController.forward();
                  });
                } else if (_counter > 32 && _counter < 66) {
                  _counterNumberColor = Colors.greenAccent;
                } else if (_counter > 65 && _counter < 100) {
                  _counterNumberColor = Color(0xffFE4362);
                  
                } else if (_counter > 99) {
                  _counterNumberColor = Color(0xffFAB825);
                  // _counterNumberColor = Colors.amber.withOpacity(0.8);
                }
              });
            },
            child: Container(
              color: Colors.green.withOpacity(0.0),
              width: screenWidth,
              height: screenHeight,
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.vertical,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          _counter = 0;
                          _slideController.reverse();
                          // _counterColor = brightColor1;
                          _counterNumberColor = Colors.white.withOpacity(0.8);
                        });
                      },
                      child: SlideTransition(
                        position: _animation,
                        child: Chip(
                          label: Text(
                            "تصفير العداد",
                            style: TextStyle(
                                color: _counterColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          labelPadding: EdgeInsets.all(8.0),
                          backgroundColor: _counterNumberColor,
                          elevation: 0.0,
                        ),
                      ),
                    ),
                    Card(
                      shape: CircleBorder(
                          side: BorderSide(
                              color: _counterNumberColor.withOpacity(0.95),
                              width: 5.0)),
                      elevation: 20.0,
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      child: CircleAvatar(
                        backgroundColor: _counterColor.withOpacity(0.96),
                        //minRadius: 110.0,
                        maxRadius: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          _counter != 0 ? _counter.toString() : "ابدأ",
                          style: TextStyle(
                              fontSize: 70.0,
                              color: _counterNumberColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
