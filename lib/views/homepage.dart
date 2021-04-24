import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qulock_app/views/clock_view.dart';
import 'package:intl/intl.dart';
import 'package:qulock_app/enums.dart';

import '../data.dart';
import '../models/menu_info.dart';

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
            children: menuItems
                .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                .toList(),
          ),

          ///左側アイコンと右側時計部分とを隔てるライン
          VerticalDivider(
            color: Colors.white,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget child) {
                if (value.menuType != MenuType.clock) return Container();

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          'Clock',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formattedTime,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 64),
                            ),
                            Text(
                              formattedDate,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                          flex: 4,
                          fit: FlexFit.tight,
                          child: Align(
                            alignment: Alignment.center,
                            child: ClockView(
                                size: MediaQuery.of(context).size.height / 4),
                          )),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Timezone',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(Icons.language, color: Colors.white),
                                SizedBox(width: 16),
                                Text(
                                  'UTC' + offsetSign + timezoneString,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return FlatButton(
          ///右上だけカーブをかけている
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(32))),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          color: currentMenuInfo.menuType == value.menuType
              ? Colors.blue[700]
              : Colors.transparent,
          onPressed: () {
            ///ManuInfoをProviderの監視対象にする
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: [
              Image.asset(
                currentMenuInfo.imageSource,
                scale: 10, //小さくなると表示が大きくなる
              ),
              SizedBox(height: 16), //左側アイコンのサイズ
              Text(
                currentMenuInfo.title ?? '',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}
