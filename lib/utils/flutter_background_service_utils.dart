// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:secucalls/utils/data_call.dart';

Future<bool> requestPermission() async {
  var status = await Permission.phone.request();
  return switch (status) {
    PermissionStatus.denied ||
    PermissionStatus.restricted ||
    PermissionStatus.limited ||
    PermissionStatus.permanentlyDenied =>
      false,
    PermissionStatus.provisional || PermissionStatus.granted => true,
  };
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  print("request permission for overlay, screen height is");
  var state = false;
  var showPopup = false;
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    print("state is $state and $showPopup");
    if (state == true && showPopup == false) {
      showPopup = true;
      if (await FlutterOverlayWindow.isActive()) return;
      await FlutterOverlayWindow.showOverlay(
        enableDrag: true,
        overlayTitle: "X-SLAYER",
        overlayContent: 'Overlay Enabled',
        flag: OverlayFlag.defaultFlag,
        height: WindowSize.matchParent,
        positionGravity: PositionGravity.auto,
        width: WindowSize.matchParent,
        startPosition: const OverlayPosition(0, -259),
      );
    }
    if (state == false) {
      showPopup = false;
      await FlutterOverlayWindow.closeOverlay();
    }
  });

  PhoneState.stream.listen((event) async {
    //PhoneState status = PhoneState.nothing();
    switch (event.status) {
      case PhoneStateStatus.CALL_INCOMING:
        print("show pop up incoming");
        await getInformationFromCall(event.number);
        state = true;
      case PhoneStateStatus.NOTHING:
        print("show nothing");
        state = false;
        await FlutterOverlayWindow.closeOverlay();
      case PhoneStateStatus.CALL_ENDED:
        state = false;
        print("show call end");
        await FlutterOverlayWindow.closeOverlay();
      case PhoneStateStatus.CALL_STARTED:
        state = false;
        print("show start call");
        await FlutterOverlayWindow.closeOverlay();
    }
  });
}
