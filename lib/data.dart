import 'package:qulock_app/constants/theme_data.dart';
import 'package:qulock_app/enums.dart';

import 'models/alarm_info.dart';
import 'models/menu_info.dart';

///MenuInfoのリスト化
List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock, title: 'Clock', imageSource: 'assets/icon_btc.png'),
  MenuInfo(MenuType.alarm, title: 'Alarm', imageSource: 'assets/icon_btc.png'),
  MenuInfo(MenuType.timer, title: 'Timer', imageSource: 'assets/icon_btc.png'),
  MenuInfo(MenuType.stopwatch,
      title: 'Stopwatch', imageSource: 'assets/icon_btc.png'),
];

///Alarm画面において表示するListViewにわたすためのリスト
List<AlarmInfo> alarms = [
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 1)),
      title: 'Offie',
      gradientColors: GradientColors.sky),
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 2)),
      title: 'Sport',
      gradientColors: GradientColors.sunset),
];
