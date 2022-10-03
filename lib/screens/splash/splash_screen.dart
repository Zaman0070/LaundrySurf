import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:laundry_app/navigation_page/user_nevigation_page.dart';
import 'package:laundry_app/screens/splash/onboardScreen.dart';

import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 4),
          () =>
              Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const OnBoardScreen()))),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.h,
          ),
          Center(
            child: Hero(
              tag: 'logo',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(
                      'assets/logo/logo.png',
                      fit: BoxFit.cover,
                      color: const Color(0xff27C1F9),
                      height: 12.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            //width: 250.0,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 30.0,
                color: Color(0xff27C1F9),
                fontFamily: 'Bobbers',
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('Laundry Hub ',
                      speed: const Duration(milliseconds: 150)),

                ],
              ),
            ),
          ),
          SizedBox(
            height: 28.h,
          ),
          SpinKitCircle(
            size: 50,
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xff27C1F9),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
