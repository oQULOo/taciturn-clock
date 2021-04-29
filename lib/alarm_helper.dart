import 'package:sqflite/sqflite.dart';

final String tableName = 'alarm';
final String columnId = 'id';
final String culumnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';

///データベースクラスは他から呼び出されたくないためシングルトンで作成する
///データベースが作成される1度のみ呼び出される
class AlarmHelper {
  Database _database;

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
        db.execute('');
      },
    );
    return database;
  }
}
