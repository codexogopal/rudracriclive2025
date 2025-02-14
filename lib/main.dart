import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jacpotline/Constant.dart';
import 'package:jacpotline/controllers/HomeController.dart';
import 'package:jacpotline/controllers/MyTransactionController.dart';
import 'package:jacpotline/session/SessionManager.dart';
import 'package:jacpotline/theme/mythemcolor.dart';
import 'package:jacpotline/ui/home/DashboardScreen.dart';
import 'package:jacpotline/utils/common_color.dart';
import 'package:jacpotline/utils/common_dialog.dart';
import 'package:jacpotline/utils/styleUtil.dart';
import 'package:provider/provider.dart';

import 'SplashScreen.dart';
import 'controllers/LiveMatchControllers.dart';
import 'controllers/LoginController.dart';
import 'controllers/MatchDetailController.dart';
import 'controllers/NewsController.dart';
import 'controllers/SeriesController.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /* SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: myprimarycolor, // Set your desired color
      statusBarBrightness: Brightness.light, // Adjust for light/dark text
    ));*/
    // ThemeMode themeMode = ThemeMode.system == Brightness.light ? ThemeMode.light : ThemeMode.dark;
    // bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    // setStatusBarColor(themeMode);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(create: (_) => HomeController()),
        ChangeNotifierProvider<NewsController>(create: (_) => NewsController()),
        ChangeNotifierProvider<SeriesController>(
            create: (_) => SeriesController()),
        ChangeNotifierProvider<MatchDetailController>(
            create: (_) => MatchDetailController()),
        ChangeNotifierProvider<LiveMatchController>(
            create: (_) => LiveMatchController()),
        ChangeNotifierProvider<LoginController>(
            create: (_) => LoginController()),
        ChangeNotifierProvider<MyTransactionController>(
            create: (_) => MyTransactionController()),
      ],
      child: Consumer<HomeController>(builder: (context, myData, _) {
        SessionManager.init();
        return MaterialApp(
          navigatorKey: CommanDialog.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: Constant.appName,
          themeMode: SessionManager.isAppDarkTheme() == null ? ThemeMode.system :
          SessionManager.isAppDarkTheme() == true ? ThemeMode.dark :
          ThemeMode.light,
          // themeMode: ThemeMode.dark,
          theme: ThemeData(
            useMaterial3: false,
            primarySwatch: myprimarycolor,
            primaryColor: myprimarycolor,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                elevation: 0, foregroundColor: Colors.white),
            brightness: Brightness.light,
            dividerColor: myprimarycolor,
            focusColor: myprimarycolor,
            hintColor: Colors.black54,
            canvasColor: Colors.white,
            indicatorColor: Colors.black,
            colorScheme: ColorScheme.light(
              primary: myprimarycolor,
              secondary: myprimarycolor,
              primaryContainer: Colors.white,
              secondaryContainer: Color(CommonColor.bgColor),
              onSecondary: myprimarycolor.shade400,
              onPrimary: myprimarycolor.shade50,
              // ... other color roles (refer to Material Design 3 documentation for a complete list)
            ),
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: myprimarycolor,
              ),
            ),
            tabBarTheme: const TabBarTheme(
              indicatorColor: Color(0XFFd2828d),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.blueGrey,
            ),
            primaryColorDark: Colors.black,
            textTheme: const TextTheme(
              headlineLarge:
                  TextStyle(fontSize: 20.0, color: Colors.black, height: 1.35),
              headlineMedium: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "sb",
                  color: Colors.black,
                  height: 1.35),
              headlineSmall: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontFamily: "os",
                  height: 1.35),
              displaySmall: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "os",
                  color: Colors.black,
                  height: 1.35),
              displayMedium: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "os",
                  color: Colors.black,
                  height: 1.35),
              displayLarge: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "os",
                  color: Colors.black,
                  height: 1.5),
              titleMedium: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "m",
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  height: 1.35),
              titleLarge: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                  fontFamily: "os",
                  height: 1.35),
              titleSmall: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontFamily: "os",
                  height: 1.35),
              bodyMedium: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                height: 1.35,
                fontFamily: "os",
              ),
              bodyLarge: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  height: 1.35,
                  fontFamily: "os"),
              bodySmall: TextStyle(
                  fontSize: 12.0,
                  color: myprimarycolor,
                  height: 1.35,
                  fontFamily: "os"),
              labelSmall: TextStyle(color: Colors.black38, fontFamily: "sb"),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: false,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.black,
              ),
            ),
            primarySwatch: myprimarycolor,
            primaryColor: myprimarycolor,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                elevation: 0, foregroundColor: Colors.white),
            brightness: Brightness.dark,
            dividerColor: myprimarycolor,
            focusColor: myprimarycolor,
            hintColor: Colors.white,
            canvasColor: Colors.black,
            indicatorColor: Colors.white,
            colorScheme: ColorScheme.dark(
              primary: const Color(0XFF0c131b),
              secondary: myprimarycolor,
              primaryContainer: Color(CommonColor.darkBgColor),
              secondaryContainer: Color(CommonColor.bgNightColor),
              onSecondary: Color(CommonColor.black54),
              onPrimary: Colors.black,
              // ... other color roles (refer to Material Design 3 documentation for a complete list)
            ),
            tabBarTheme: const TabBarTheme(
              indicatorColor: Color(0XFFd2828d),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
            ),
            primaryColorDark: Colors.white,
            textTheme: const TextTheme(
              headlineLarge:
                  TextStyle(fontSize: 20.0, color: Colors.white, height: 1.35),
              headlineMedium: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "sb",
                  color: Colors.white,
                  height: 1.35),
              headlineSmall: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontFamily: "sb",
                  height: 1.35),
              displaySmall: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "sb",
                  color: Colors.white,
                  height: 1.35),
              displayMedium: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "sb",
                  color: Colors.white,
                  height: 1.35),
              displayLarge: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "sb",
                  color: Colors.white,
                  height: 1.5),
              titleMedium: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "sb",
                  color: Colors.white,
                  height: 1.35),
              titleLarge: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontFamily: "sb",
                  height: 1.35),
              bodyMedium: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
                height: 1.35,
                fontFamily: "sb",
              ),
              bodyLarge: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  height: 1.35,
                  fontFamily: "sb"),
              bodySmall: TextStyle(
                  fontSize: 12.0,
                  color: myprimarycolor,
                  height: 1.35,
                  fontFamily: "sb"),
              labelSmall: TextStyle(color: Colors.white60, fontFamily: "sb"),
            ),
          ),
          home: const SplashScreen(),
        );
      }),
    );
  }
}
