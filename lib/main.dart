import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/generate_route.dart';

import 'screen/splash/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: fullScreenPortraitSize,
      child: MaterialApp(
        onGenerateRoute: generateRoute,
        home: SplashScreen(),
      ),
    );
  }
}
