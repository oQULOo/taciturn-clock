import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qulock_app/alarm_helper.dart';
import 'package:qulock_app/data.dart';
import 'package:qulock_app/models/alarm_info.dart';

import '../main.dart';

class AlarmPage extends StatefulWidget {
  AlarmPage({Key key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  ///アラームを追加した場合に必要になるものシリーズ
  DateTime _alarmTime;
  String _alarmTimeString;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>> _alarms;
  List<AlarmInfo> _currentAlarms;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print('--------database initialized');
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //Alarmのタイトルを左寄せに
        children: [
          Expanded(
            child: ListView(
                children: alarms.map<Widget>((alarm) {
              return Container(
                ///カードとカードの間にいい感じにスペースが入るように
                margin: const EdgeInsets.only(bottom: 32),

                ///child以下の要素がいい感じにpaddingを持つように親Containerで設定
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: alarm.gradientColorIndex,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: alarm.gradientColorIndex.last.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(4, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.label,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Office',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Switch(
                          onChanged: (bool value) {},
                          value: true,
                          activeColor: Colors.white,
                        ),
                      ],
                    ),
                    Text(
                      'Mon-Fri',
                      style: TextStyle(color: Colors.white),
                    ),

                    ///時刻と矢印
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///時刻
                        Text(
                          '18:00 PM',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).followedBy([
              if (alarms.length < 5)
                DottedBorder(
                  strokeWidth: 0,
                  color: Colors.white,
                  borderType: BorderType.RRect, //点線を角丸にする
                  radius: Radius.circular(12), //角丸のアール値を指定
                  dashPattern: [7, 7], //[線分の長さ,間隔の幅]
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: FlatButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      onPressed: () {
                        scheduleAlarm();
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.add,
                            size: 36,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Add Alarm',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              else
                Text('Only 5 alarms allowed!'),
            ]).toList()),
          ), //リストはデータ型と一致する必要があるので、.map((e)のeにはAlarmInfo型の変数をいれる
        ],
      ),
    );
  }

  void scheduleAlarm(
      {DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'QULO',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    ///LocalNotification_iOS固有
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'bensound-dreams.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    ///iOS,Android両方で使用するために必要
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Office',
        alarmInfo.title,
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
}
