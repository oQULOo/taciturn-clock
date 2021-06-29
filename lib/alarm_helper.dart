import 'package:qulock_app/models/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

final String tableAlarm = 'alarm';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';

///データベースクラスは他から呼び出されたくないためシングルトンで作成する
///データベースが作成される1度のみ呼び出される
class AlarmHelper {
  static Database _database;
  static AlarmHelper _alarmHelper;

  AlarmHelper._createInstance();
  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._createInstance();
    }
    return _alarmHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  ///データベースの初期化
  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath(); //データベースを保存するパスをdir(ディレクトリの意)に代入
    var path = dir + 'alarm.db'; //データベースを開く場所
    ///データベースへの接続
    var database = await openDatabase(
      path,
      version: 1,

      ///onCreate:初期定義。この中でテーブルを作成
      onCreate: (db, version) {
        db.execute('''
        create table $tableAlarm(
          $columnId integer primary key autoincrement,
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer,
          $columnColorIndex integer
        )
        ''');
      },
    );
    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    var result = await db.insert(tableAlarm, alarmInfo.toMap());
    print('result : $result');
  }

  ///TODOちゃんと理解する
  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];

    var db = await this.database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
}
