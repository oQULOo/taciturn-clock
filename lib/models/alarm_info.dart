import 'package:flutter/material.dart';

///Alarmにおけるモデル
class AlarmInfo {
  ///プロパティ
  DateTime alarmDateTime;
  String description;
  bool isActive;
  List<Color> gradientColors; //Alarmページのカードのグラデーションの色

  ///コンストラクター
  AlarmInfo(this.alarmDateTime, {this.description, this.gradientColors});
}
