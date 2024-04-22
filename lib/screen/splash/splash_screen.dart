// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/constant/constants.dart';
import 'package:secucalls/constant/style.dart';
import 'package:secucalls/screen/login/login_screen.dart';
import 'package:secucalls/screen/splash/splash_screen_def.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // You can design your splash screen UI here
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: top_margin_logo.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: left_margin_logo.w, right: left_margin_logo.w,
              ),
              child: Image.asset(
                "lib/assets/logo.png",
                width: size_logo.width.w,
                height: size_logo.height.h,
              ),
            ),
            Container(
              padding: EdgeInsets.only( 
                left: left_margin_text.w,
                right: left_margin_text.w,
                top: top_margin_text.h,
              ),
              height: size_text.height.h,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text_title,
                  textAlign: TextAlign.center,
                  style: textGray22Italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
