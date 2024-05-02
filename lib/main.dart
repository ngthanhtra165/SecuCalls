import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/generate_route.dart';
import 'package:secucalls/screen/overlay/overlay.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secucalls/utils/flutter_background_service_utils.dart';

import 'screen/splash/splash_screen.dart';

void main() async {
  //RonStart();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  runApp(const MyApp());
}

onStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await initializeService();
}

@pragma("vm:entry-point")
void overlayMain() async {
  debugPrint("Starting Alerting Window Isolate!");
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: TrueCallerOverlay()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: fullScreenPortraitSize,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRoute,
        home: SplashScreen(),
      ),
    );
  }
}
