import 'package:qulock_app/enums.dart';

///コンストラクタ
class MenuInfo {
  ///メンバ変数
  MenuType menuType;
  String title;
  String imageSource;

  ///メンバ変数の初期化
  MenuInfo(this.menuType, {this.title, this.imageSource});
}
