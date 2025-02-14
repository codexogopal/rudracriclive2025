import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jacpotline/controllers/HomeController.dart';
import 'package:jacpotline/session/SessionManager.dart';
import 'package:jacpotline/ui/home/DashboardScreen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Provider.of<HomeController>(context, listen: false).changeThemeNotify();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    Timer(const Duration(seconds: 1), () {
      HomeController provider = Provider.of(context, listen: false);
      provider.getBottomAds(context);
      provider.getHomeOpenAds(context);
    });
    Timer(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => const DashboardScreen(),), (route) => false,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      //backgroundColor: const Color.fromRGBO(250, 224, 61, 1.0),
      // \backgroundColor: colors: [Color.fromRGBO(254, 230, 45, 1), Color.fromRGBO(233, 62, 58, 1)]
      backgroundColor: Colors.transparent,
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset('assets/images/splash_screen.png',
              fit: BoxFit.cover,),
          ),
        ));
  }
}