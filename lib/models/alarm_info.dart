import 'package:flutter/material.dart';

///Alarmにおけるモデル
class AlarmInfo {
  ///プロパティ
  int id;
  String title;
  DateTime alarmDateTime;
  bool isPending;
  List<Color> gradientColorIndex; //Alarmページのカードのグラデーションの色

  ///コンストラクター
  AlarmInfo(
      {this.id,
      this.title,
      this.alarmDateTime,
      this.isPending,
      this.gradientColorIndex});

  ///quicktypeにて作成したJsonのKeyValue
  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: json["id"],
        title: json["title"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        isPending: json["isPending"],
        gradientColorIndex: json["gradiwntColorIndex"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
      };
}
