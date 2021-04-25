import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qulock_app/data.dart';

class AlarmPage extends StatefulWidget {
  AlarmPage({Key key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //Alarmのタイトルを左寄せに
        children: [
          Text(
            'Alarm',
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 24, color: Colors.white),
          ),
          Expanded(
            child: ListView(
                children: alarms.map((alarm) {
              return Container(
                ///カードとカードの間にいい感じにスペースが入るように
                margin: const EdgeInsets.only(bottom: 32),

                ///child以下の要素がいい感じにpaddingを持つように親Containerで設定
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(4, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(24)),
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
                          '07:00 AM',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),

                        ///時刻右手の下向き矢印
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 36,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ],
                ),
              );
            }).toList()),
          ), //リストはデータ型と一致する必要があるので、.map((e)のeにはAlarmInfo型の変数をいれる
        ],
      ),
    );
  }
}