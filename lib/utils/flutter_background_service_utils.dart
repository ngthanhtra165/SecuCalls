import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:phone_state_background/phone_state_background.dart';


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
  service.startService();
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();
  print("onStart [TEST]");
  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  // SharedPreferences preferences = await SharedPreferences.getInstance();
  // await preferences.setString("hello", "world");

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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
  // PhoneState.stream.listen((event) {
  //   print("Listen stream");
  //   print(event.status);
  //   print(event.number);
  // });
  // print("Start Stream");
  // final permission = await PhoneStateBackground.checkPermission();
  // await PhoneStateBackground.initialize(phoneStateBackgroundCallbackHandler);
  // if (permission == true) {
  //   //await PhoneStateBackground.initialize(phoneStateBackgroundCallbackHandler);
  // } else {
  //   print("false");
  //   await PhoneStateBackground.requestPermissions();
  //   final permission = await PhoneStateBackground.checkPermission();
  // }
}

  // bring to foreground
  // Timer.periodic(const Duration(seconds: 1), (timer) async {
  //   //print("onStart [TEST] 1 2 3....");
  //   if (service is AndroidServiceInstance) {
  //     print(service);
  //     if (await service.isForegroundService()) {
  //       /// OPTIONAL for use custom notification
  //       /// the notification id must be equals with AndroidConfiguration when you call configure() method.
  //       flutterLocalNotificationsPlugin.show(
  //         888,
  //         'COOL SERVICE',
  //         'Awesome ${DateTime.now()}',
  //         const NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             'my_foreground',
  //             'MY FOREGROUND SERVICE',
  //             icon: 'ic_bg_service_small',
  //             ongoing: true,
  //           ),
  //         ),
  //       );

  //       // if you don't using custom notification, uncomment this
  //       // service.setForegroundNotificationInfo(
  //       //   title: "My App Service",
  //       //   content: "Updated at ${DateTime.now()}",
  //       // );
  //     }
  //   }
    
  //   // service.invoke(
  //   //   'update',
  //   //   {
  //   //     "current_date": DateTime.now().toIso8601String(),
  //   //     "device": device,
  //   //   },
  //   // );
  // });




