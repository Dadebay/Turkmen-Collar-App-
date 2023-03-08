import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/modules/auth/connection_check/views/connection_check.dart';

import 'app/constants/notification_service.dart';
import 'app/utils/translations.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await flutterLocalNotificationsPlugin.show(
    message.data.hashCode,
    message.data['body'],
    message.data['title'],
    NotificationDetails(
      iOS: const IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channel.description,
        color: Colors.white,
        styleInformation: const BigTextStyleInformation(''),
        icon: '@mipmap/ic_launcher',
      ),
    ),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  await NotificationService().askPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yaka',
      useInheritedMediaQuery: true,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: normsProRegular,
        colorSchemeSeed: kPrimaryColor,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          shadowColor: kPrimaryColor,
        ),
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent.withOpacity(0)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      fallbackLocale: const Locale('tr'),
      locale: storage.read('langCode') != null
          ? Locale(storage.read('langCode'))
          : const Locale(
              'tr',
            ),
      translations: MyTranslations(),
      defaultTransition: Transition.fade,
      home: const ConnectionCheckpage(),
    );
  }
}
