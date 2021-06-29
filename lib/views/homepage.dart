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
      backgroundColor: Colors.blueGrey[50],
      body: Column(
        children: [
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget child) {
                if (value.menuType == MenuType.clock)
                  return ClockPage();
                else if (value.menuType == MenuType.alarm)
                  return AlarmPage();
                else
                  return Container();
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return Expanded(
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            padding: const EdgeInsets.symmetric(vertical: 28.0),
            color: currentMenuInfo.menuType == value.menuType
                ? Colors.blueGrey[100]
                : Colors.transparent,
            onPressed: () {
              ///ManuInfoをProviderの監視対象にする
              var menuInfo = Provider.of<MenuInfo>(context, listen: false);
              menuInfo.updateMenu(currentMenuInfo);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  currentMenuInfo.imageSource,
                  scale: 1, //小さくなると表示が大きくなる
                  color: currentMenuInfo.menuType == value.menuType
                      ? Colors.white
                      : Colors.blueGrey[200],
                ),
                SizedBox(width: 16), //左側アイコンのサイズ
                Text(
                  currentMenuInfo.title ?? '',
                  style: currentMenuInfo.menuType == value.menuType
                      ? TextStyle(color: Colors.white, fontSize: 14)
                      : TextStyle(color: Colors.blueGrey[200], fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
