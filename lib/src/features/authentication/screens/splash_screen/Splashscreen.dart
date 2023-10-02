import 'dart:async';
import 'package:collectors/main.dart';
import 'package:collectors/src/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Timer(
    //     const Duration(seconds: 5),
    //     () => Navigator.pushReplacement(context,
    //         MaterialPageRoute(builder: (context) => const LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      color: appDark,
      //child:FlutterLogo(size:MediaQuery.of(context).size.height)
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.,
        children: [
          Image.asset(
            countyLogo,
            width: 100 * fem,
            height: 100 * fem,
          ),
          SizedBox(
            height: 20 * fem,
          ),
          const DefaultTextStyle(
            style: TextStyle(decoration: TextDecoration.none),
            child: Text(
              'County Collectors',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,fontSize: 20),
            ),
          ),
          SizedBox(
            height: 250 * fem,
          ),
          Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: appGold,
              size: 30,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const DefaultTextStyle(
            style: TextStyle(decoration: TextDecoration.none),
            child: Text(
              'loading...',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
