import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'mesbaha.dart';

class AboutApp extends StatelessWidget {
  final List _myContacts = [
    {
      "isFA": false,
      "icon": Icons.mail,
      "url": "mailto:moahmedsalem51@gmail.com?subject=From Azkary App"
    },
    {
      "isFA": true,
      // "icon": FontAwesomeIcons.light,
      "icon": FontAwesomeIcons.facebook,
      "url": "https://bit.ly/AzkaryApp-fb"
    },
    {
      "isFA": true,
      "icon": FontAwesomeIcons.github,
      "url": "https://github.com/mohammedsalem97"
    },
    {
      "isFA": true,
      "icon": FontAwesomeIcons.behance,
      "url": "https://www.behance.net/mohammedsalemdesigns"
    },
    {
      "isFA": true,
      "icon": FontAwesomeIcons.youtube,
      "url":
          "https://www.youtube.com/channel/UCSSjpDH5WLg-yBLs4spyzOw?view_as=subscriber"
    },
  ];

  final StrutStyle _strutStyle = StrutStyle(
    height: 1.5,
    forceStrutHeight: true,
  );
  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    var _mediaQuery = MediaQuery.of(context);
    TextStyle _textStyle = Theme.of(context)
        .textTheme
        .body1
        .apply(color: Colors.black.withOpacity(0.7));

    var linearGradient = LinearGradient(
        colors: [
          //Color(0xff38ef7d),
          Colors.blueGrey,
          Color(0xff11998e),
        ].reversed.toList(),
        begin: Alignment.topRight,
        end: Alignment.bottomLeft);
    var highlightedTextStyle = _textStyle.apply(
      fontSizeDelta: 2,
      color: Colors.white,
    );
    return Hero(
      tag: 'app info',
      placeholderBuilder: (context,size,widget){
        return FaIcon(FontAwesomeIcons.questionCircle);
      },
      child: Stack(
        children: <Widget>[
          Scaffold(
            endDrawer: Mesbaha(),
            backgroundColor: Color(0xFF00bdaa),
            appBar: AppBar(
              title: Text(
                "عن التطبيق",
                style: _theme.appBarTheme.textTheme.headline
                    .copyWith(fontSize: 15.0),
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    MyCard(
                      color: Color(0xFFfe346e),
                      child: Text(
                        "تطبيق أذكاري هو تطبيق للهواتف الذكية يتيح لمستخدمه قراءة الأذكار الصحيحة المتواترة عن النبي صلَّى الله عليه وسلَّم في تصميم أنيق وجذاب قلَّما تجده في التطبيقات الإسلامية",
                        textAlign: TextAlign.center,
                        strutStyle: _strutStyle,
                        style: _textStyle.apply(color: Color(0xfff1e7b6)),
                      ),
                    ),
                    MyCard.highlighted(
                      color: Colors.deepOrange[200],
                      child: Container(
                        width: _mediaQuery.size.width,
                        child: Text(
                          "مميزات التطبيق",
                          textAlign: TextAlign.center,
                          style: highlightedTextStyle.apply(color: Colors.black.withOpacity(0.7)),
                        ),
                      ),
                    ),
                    MyCard.highlighted(
                      child: Text(
                        "يحتوي تطبيق أذكاري على أكثر من 130 مجموعة من الأذكار والأدعية\n"
                        "كما أن تطبيق أذكاري يمكنه حساب مواقيت الصلاة بدقة متناهية باستخدام معلومات موقعك مثل خط الطول وخط العرض الجغرافي\n"
                        "وكذلك يحتوي على مسبحة إلكترونية جذابة تظهر إذا سحبت الشاشة من اليسار إلى اليمين في كافة صفحات التطبيق\n"
                        "يحتوي أيضاً على قائمة مفضلة يمكنك إضافة أو حذف العناصر منها بسهولة \n"
                        "كما أن التطبيق يرسل لك إشعارات تذكرك بقراءة أذكار النوم وأذكار الاستيقاظ من النوم\n"
                        "ويمكنك أيضاً معرفة ثواب بعض الأذكار بالضغط مطولاً على الدعاء\n"
                        "ويمكنك تغيير نوع الخط في صفحة الأذكار بالضغط على كلمة 'خط' الموجودة في أعلى يمين الشاشة\n"
                        "بالإضافة إلى أنَّ تطبيق أذكاري مفتوح المصدر open source مما يتيح لمن أراد المشاركة في تطويره وتحسينه إمكانية المشاركة بدون أية قيود أو حقوق ملكية أو ما شابه من القيود !\n"
                        "",
                        strutStyle: _strutStyle,
                        style: _textStyle,
                      ),
                    ),
                    MyCard.highlighted(
                      color: Color(0xFFfe346e).withOpacity(0.8),
                      child: Text(
                        "ما الجديد ؟",
                        textAlign: TextAlign.center,
                        style: highlightedTextStyle,
                      ),
                    ),
                    MyCard(
                      color: Color(0xFFfe346e),
                      child: Text(
                        "تم إضافة إمكانية حساب أوقات الصلاة بدقة عالية حسب موقعك الجغرافي\n "
                        "تحسين واجهة المستخدم لشكل أكثر حداثة يراعي معايير التصميم الجرافيكي وإمكانية الرؤية والقراءة المريحة\n"
                        "التطبيق الآن يدعم الوضع الليلي المريح للعين أثناء القراءة\n"
                        "كما يمكنك تغيير الخط المفضل لك من بين أربعة خطوط أنيقة لعرض المحتوى داخل صفحات التطبيق\n"
                        "يمكنك أيضاً البحث عن الأذكار من خلال أيقونة البحث في الصفحة الرئيسية\n"
                        "يمكنك الآن الدخول إلى صفحة -إسلامي أونلاين- لتتصفح مجموعة منتقاة بعناية من الفيديوهات والتسجيلات الصوتية الهادفة لبناء وعي المسلم المعاصر وزيادة القرب من الله عز وجل وزيادة روح الإيمان لديك\n"
                        "كما أنه ستصلك من حين لآخر إشعارات تذكرك بفضل عمل صالح أو بصيام أيام الاثنين والخميس والليالي القمرية أو بفضل ذكر أو دعاء أو حتى يرشح لك فيديو أو درس ديني\n "
                        "ويمكنك أيضاً مشاركة الدعاء في مواقع التواصل الاجتماعي بالضغط مطولاً عليه ",
                        style: _textStyle.apply(
                            color: Colors.white, fontWeightDelta: -50),
                        strutStyle: _strutStyle,
                      ),
                    ),
                    MyCard.highlighted(
                      color: Colors.blueGrey[300],
                      child: Text(
                        "شكر خاص",
                        style: highlightedTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    MyCard.highlighted(
                      color: Colors.blueGrey,
                      child: Text(
                        "للأستاذ الفنان والخطاط المتميز\n"
                        "عبد السميع رجب سالم\n"
                        "على ما قدم من المساعدة المعنوية والمادية في تطوير تطبيق أذكاري للشكل الحالي من خلال تقديمه لأحد الخطوط التي صممها بنفسه بشكل مجاني لتحسين طريقة عرض النصوص داخل التطبيق كما قدم مشكوراً التصميم الحالي لأيقونة التطبيق\n "
                        "فجزاه الله خيراً",
                        style: highlightedTextStyle.apply(
                            fontSizeDelta: -2.0, fontWeightDelta: -200),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    MyCard.highlighted(
                      color: Colors.deepOrange[200],
                      child: Text(
                        "عن المطور",
                        style: highlightedTextStyle.apply(fontSizeDelta: -2.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    MyCard.highlighted(
                      color: Colors.deepOrange[300],
                      child: Column(
                        children: <Widget>[
                          Text(
                            "محمد أحمد سالم",
                            style: highlightedTextStyle.copyWith(
                                fontSize: 12.0, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          Divider(),
                          Text(
                            "Flutter Developer\n"
                            "UI Designer\n"
                            "Graphic Designer\n"
                            "Motion Graphic Designer\n"
                            "Web Designer\n"
                            "Freelancer",
                            style: highlightedTextStyle.apply(
                                fontSizeDelta: -2.0, fontWeightDelta: -200),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    MyCard.highlighted(
                      color: Colors.deepPurple[400],
                      child: Text(
                        "تواصل معي",
                        style: highlightedTextStyle.apply(fontSizeDelta: -2.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    MyCard.highlighted(
                      color: Colors.deepPurple[900],
                      child: Row(
                        children: <Widget>[
                          Spacer(
                            flex: 2,
                          ),
                          for (var el in _myContacts)
                            Expanded(
                              flex: 3,
                              child: IconButton(
                                icon: el["isFA"]
                                    ? FaIcon(
                                        el["icon"],
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        el["icon"],
                                        color: Colors.white,
                                      ),
                                onPressed: () async {
                                  if (await canLaunch(el["url"]))
                                    await launch(el["url"]);
                                },
                              ),
                            ),
                          Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final double elevation;
  MyCard(
      {this.child, this.color = const Color(0xFFECECEC), this.elevation = 6.0});
  MyCard.highlighted(
      {this.child,
      this.color = const Color(0xFFFFAB91),
      this.elevation = 10.0});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
      margin: EdgeInsets.all(3.0),
      color: color,
      elevation: elevation,
    );
  }
}
