import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'clock_view.dart';

///時計表示ページ
class ClockPage extends StatefulWidget {
  ClockPage({Key key}) : super(key: key);

  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 32,
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  formattedTime,
                  style: TextStyle(color: Colors.blueGrey[200], fontSize: 64),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(color: Colors.blueGrey[200], fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Flexible(
                flex: 0,
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.center,
                  child:
                      ClockView(size: MediaQuery.of(context).size.height / 3.5),
                )),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Timezone',
                  style: TextStyle(color: Colors.blueGrey[200], fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.language, color: Colors.blueGrey[200]),
                    SizedBox(width: 16),
                    Text(
                      'UTC' + offsetSign + timezoneString,
                      style:
                          TextStyle(color: Colors.blueGrey[200], fontSize: 22),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
