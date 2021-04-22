import 'package:flutter/material.dart';
import 'package:qulock_app/enums.dart';

///Clock,Alarm,Timer,Stopwatchの4つのメニューのモデル
class MenuInfo extends ChangeNotifier {
  ///メンバ変数
  MenuType menuType;
  String title;
  String imageSource;

  ///メンバ変数の初期化：コンストラクタ
  MenuInfo(this.menuType, {this.title, this.imageSource});

  ///内容が更新された場合、現在の値に最新の値を代入する
  updateMenu(MenuInfo menuInfo) {
    this.menuType = menuInfo.menuType;
    this.title = menuInfo.title;
    this.imageSource = menuInfo.imageSource;

    ///重要！内容に更新が入った場合consumerに知らせる役割
    notifyListeners();
  }
}
