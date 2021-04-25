import 'package:flutter/material.dart';

///Alarmにおけるモデル
class AlarmInfo {
  ///プロパティ
  int id;
  String title;
  DateTime alarmDateTime;
  bool isPending;
  List<Color> gradientColors; //Alarmページのカードのグラデーションの色

  ///コンストラクター
  AlarmInfo(
      {this.id,
      this.title,
      this.alarmDateTime,
      this.isPending,
      this.gradientColors});
}
