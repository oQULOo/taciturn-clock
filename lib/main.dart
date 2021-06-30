import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:qulock_app/enums.dart';

import 'views/homepage.dart';
import 'models/menu_info.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

///LoaclNotificationsの初期化
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///LocalNotification Android用 通知欄に表示するアイコン
  var initializationSettingsAndroid =
      AndroidInitializationSettings('QULOCK_logo');

  ///LocalNotification iOS用
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});

  ///LocalNotificationのOSごとの初期化
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });
  tz.initializeTimeZones(); //LocalNotifcation2.0〜はこれが必要
  // tz.setLocalLocation(tz.getLocation('Japan/Tokyo')); //タイムゾーンの設定

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //右上のデバッグリボンを消している
      ///ChangeNotifier<T>の<T>は変更を察知させたいクラス名をいれるが、
      ///<T>自体がChangeNotifierを継承している必要がある
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(MenuType.clock),
        child: HomePage(),
      ),
    );
  }
}
