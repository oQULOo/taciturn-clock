///Alarmにおけるモデル
class AlarmInfo {
  ///プロパティ
  DateTime alarmDateTime;
  String description;
  bool isActive;

  ///コンストラクター
  AlarmInfo(this.alarmDateTime, {this.description});
}
