

import 'package:azkar/widgets/today_quate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:scoped_model/scoped_model.dart';
import './models/user_model.dart';

///[1-create a temporary fake screen when the theme is being loaded]
///<------>[2-put a share icon to share the app webpage to download]

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  runApp(
    MyApp(),
  );
  // Timer.periodic(Duration(seconds: 1), (_){
  //   if(Widget.canUpdate(MyApp(), MyApp()))
  //   MyApp().createElement();
  // });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserScopedModel userScopedModel = UserScopedModel();
  @override
  void initState() {
    userScopedModel.autoTheme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: userScopedModel,
      child: ScopedModelDescendant<UserScopedModel>(
          builder: (context, child, model) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'أذكاري',
            color: model.userModel.isBrightMode
                ? Color(0xFFFFCB92)
                : Color(0xff4792AD),
            theme: ThemeData(
              primaryColor: Color(0xFFFFCB92),
              accentColor: Color(0xFFFF5383),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              fontFamily: model.userModel.currentFont,
              iconTheme: IconThemeData(
                color: Color(0xFFFF5383).withOpacity(0.8), //ffff
              ),
              appBarTheme: AppBarTheme(
                color: Colors.transparent,
                elevation: 0.0,
                textTheme: TextTheme(
                  headline: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16.0,
                    color: Colors.white,
                    fontFamily: model.userModel.currentFont,
                  ),
                  title: TextStyle(
                    //this is for search delegate input style
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                ),
                actionsIconTheme: IconThemeData(
                  color: Colors.white,
                  size: 24.0,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
              textTheme: TextTheme(
                body1: TextStyle(
                  color: Color(0xFFFF5383),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                ),
                body2: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                display3: TextStyle(color: Colors.black,fontWeight: FontWeight.normal),
                display4: TextStyle(
                    color: Color(0xFFFF5383).withOpacity(0.8), fontSize: 13.0),
                title: TextStyle(fontSize: 14.5),
              ),
              cardColor: Colors.white.withOpacity(0.85),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Color(0xFFFFCB92),
              ),
              snackBarTheme: SnackBarThemeData(
                backgroundColor: Colors.black.withOpacity(0.7),
                contentTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.white,
                  fontFamily: model.userModel.currentFont,
                ),
              ),
              bottomAppBarColor: Color(0xFFFF5383),
              cursorColor: Colors.white12,
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
                labelStyle: TextStyle(color: Colors.white),
              ),
              
            ),
            themeMode:
                model.userModel.isBrightMode ? ThemeMode.light : ThemeMode.dark,

            ///[DarkTheme]////////////////////////////////////////////////
            ///[DarkTheme]////////////////////[////////////////////////////
            ///[DarkTheme]////////////////////[////////////////////////////
            darkTheme: ThemeData(
              primaryColor: Color(0xFF093645),
              accentColor: Color(0xFF0E262E),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              fontFamily: model.userModel.currentFont, //'FJ', //'Abdo Master'
              iconTheme: IconThemeData(
                color: Color(0xFFFFFFFF).withOpacity(0.7),
              ),
              appBarTheme: AppBarTheme(
                color: Colors.transparent,
                elevation: 0.0,
                textTheme: TextTheme(
                  headline: TextStyle(
                      fontFamily: model.userModel.currentFont,
                      fontWeight: FontWeight.w900,
                      fontSize: 16.0,
                      color: Colors.white),
                  title: TextStyle(fontSize: 14.5),
                ),
                actionsIconTheme: IconThemeData(
                  color: Colors.white,
                  size: 24.0,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
              textTheme: TextTheme(
                body1: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                ),
                body2: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white.withOpacity(0.95),
                  shadows: [
                    Shadow(
                        color: Colors.black.withOpacity(1.0),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 3.0))
                  ],
                ),
                display3: TextStyle(color: Colors.white,fontWeight: FontWeight.normal),
                display4: TextStyle(
                    color: Color(0xFFFFFFFF).withOpacity(0.7), fontSize: 13.0),
              ),
              cardColor: Color(0xFF063A4A).withOpacity(0.85),
              snackBarTheme: SnackBarThemeData(
                backgroundColor: Color(0xff4792AD).withOpacity(0.85),
                contentTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.white,
                  fontFamily: model.userModel.currentFont,
                ),
              ),
              bottomAppBarColor: Color(0xff4792AD),
              cursorColor: Colors.black26,
              tooltipTheme: TooltipThemeData(
                decoration: BoxDecoration(
                  color: Color(0xff4792AD),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: TextStyle(
                  fontSize: 13.0,
                ),
              ),
            ),

            /// Localization Settings
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              Locale("ar", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
            ],
            locale: Locale("ar", "IR"),
            home:
                TodayQuate()
    
            );
      }),
    );
  }
}
