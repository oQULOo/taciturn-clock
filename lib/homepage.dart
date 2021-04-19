import 'package:flutter/material.dart';
import 'package:qulock_app/clock_view.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now); //inilライブラリを使用した時間の取得
    var formattedDate = DateFormat('EEE, d MMM').format(now);

    ///now.timeZoneOffset.toString()だと5:30:00.000000となるので
    ///.でsplitして、かつ、splitした最初の方(5:30:00)を選択する
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';

    ///-(マイナス)からはじまらないとき、offsetSignに+をいれる
    if (!timezoneString.startsWith('-')) offsetSign = '+';
    print(timezoneString);

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                  onPressed: () {},
                  child: Column(
                    children: [
                      FlutterLogo(),
                      Text(
                        'Clock',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  )),
            ],
          ),

          ///左側アイコンと右側時計部分とを隔てるライン
          VerticalDivider(
            color: Colors.white,
            width: 1,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Clock',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    formattedTime,
                    style: TextStyle(color: Colors.white, fontSize: 64),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  ClockView(),
                  Text(
                    'Timezone',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.language, color: Colors.white),
                      SizedBox(width: 16),
                      Text(
                        'UTC' + offsetSign + timezoneString,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
