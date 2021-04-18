import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: CustomPaint(
        painter: ClockPainter(),
      ),
    );
  }
}

///時計の描画を計算で行っていく！
class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2; //画面サイズに依存しないようにsizew.widthを使用する
    var centerY = size.width / 2;
    var center = Offset(centerX, centerY); //中心点
    var radius = min(centerX, centerY); //centerXかcenterYのうち小さい方の値を返すメソッド

    ///上で設定した円の描画色の設定
    var fillBrush = Paint()..color = Colors.amber;

    ///時計の縁の色に指定する
    var outlineBrush = Paint()
      ..color = Colors.amber[50]
      ..style = PaintingStyle.stroke //stroke:縁をつくる、fill：塗り潰し
      ..strokeWidth = 16; //縁の太さ

    canvas.drawCircle(center, radius - 40, fillBrush); //時計の内側
    canvas.drawCircle(center, radius - 40, outlineBrush); //時計の縁
  }

//再描画される際に必要：true
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
