import 'package:azkar/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'home_screen.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              brightColor1,
              darkColor1
//              Color(0xff7b4397),
//              Color(0xffdc2430),
            ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          ),
        ),
        Hero(
          tag: 'app info',
          child: Scaffold(
            endDrawer: Mesbaha(),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                "عن التطبيق",
                textScaleFactor: 0.9,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                ),
              ],
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            body: ListView(
              padding: EdgeInsets.only(
                  top: 30.0, bottom: 12.0, right: 12.0, left: 12.0),
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "تطبيق أذكاري هو تطبيق للهواتف الذكية يتيح لمستخدمه قراءة الأذكار الصحيحة المتواترة عن النبي صلَّى الله عليه وسلَّم في تصميم أنيق وجذاب قلَّما تجده في التطبيقات الإسلامية",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                          height: 1.25,
                          color: Colors.white,
                          fontSize: 18.0,
                          wordSpacing: 5.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      color: brightColor1,
                      height: 2.0,
                    ),
                    Divider(
                      color: brightColor1,
                      height: 2.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Shimmer(
                      direction: ShimmerDirection.rtl,
                      gradient:
                          RadialGradient(colors: [Colors.white, Colors.white60]),
                      child: Text(
                        "مميزات التطبيق",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            wordSpacing: 5.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Divider(
                      color: brightColor1,
                      height: 2.0,
                    ),
                    Divider(
                      color: brightColor1,
                      height: 2.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "يحتوي تطبيق أذكاري على أكثر من 130 مجموعة من الأذكار والأدعية\n"
                      "وكذلك يحتوي على مسبحة إلكترونية جذابة تظهر إذا سحبت الشاشة من اليمين إلى اليسار في كافة صفحات التطبيق\n"
                      "يحتوي أيضاً على قائمة مفضلة يمكنك إضافة أو حذف العناصر منها بالضغط مطولاً على عنوان الذكر أو الدعاء\n"
                      "كما أن التطبيق يرسل لك إشعارات تذكرك بقراءة أذكار الصباح والمساء وكذلك أذكار النوم وأذكار الاستيقاظ من النوم\n"
                      "ويمكنك أيضاً معرفة ثواب بعض الأذكار بالضغط مطولاً على الدعاء\n"
                      "ويمكنك تغيير نوع الخط في صفحة الأذكار بالضغط على كلمة 'خط' الموجودة في أعلى يمين الشاشة\n"
                      "بالإضافة إلى أنَّ تطبيق أذكاري مفتوح المصدر open source مما يتيح لمن أراد المشاركة في تطويره وتحسينه إمكانية المشاركة بدون أية قيود أو حقوق ملكية أو ما شابه من القيود !\n"
                      "كما يوجد من التطبيق نسخة لنظام Android وكذا لنظام IOS\n"
                      "",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          wordSpacing: 5.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
