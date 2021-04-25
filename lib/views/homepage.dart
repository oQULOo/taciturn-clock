import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qulock_app/views/clock_view.dart';
import 'package:intl/intl.dart';
import 'package:qulock_app/enums.dart';

import '../data.dart';
import '../models/menu_info.dart';
import 'alarm_page.dart';
import 'clock_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                if (value.menuType == MenuType.clock)
                  return ClockPage();
                else if (value.menuType == MenuType.alarm)
                  return AlarmPage();
                else
                  return Container(
                      child: RichText(
                    text: TextSpan(
                        style: TextStyle(fontSize: 20),
                        children: <TextSpan>[
                          TextSpan(text: 'Upcoming Tutorial'),
                          TextSpan(
                            text: value.title,
                            style: TextStyle(fontSize: 48),
                          ),
                        ]),
                  ));
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
