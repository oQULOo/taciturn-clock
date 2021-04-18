import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

///時計アニメーションを使うので、Statefulでかく必要がある
class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  ///@overrideすることで、内部UIが定期的に再描画されるようになる
  ///この場合、毎秒更新をかけている
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,

      ///sin・cos使うと0度スタートになるので、-90度回転させないと時計でみたときの12時起点にならない！
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

///時計の描画を計算で行っていく！
class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  ///秒針：60秒 で 360度回転する=1秒 で 6度進む

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2; //画面サイズに依存しないようにsizew.widthを使用する
    var centerY = size.width / 2;
    var center = Offset(centerX, centerY); //中心点
    var radius = min(centerX, centerY); //centerXかcenterYのうち小さい方の値を返すメソッド

    ///上で設定した円の描画色の設定
    var fillBrush = Paint()..color = Colors.amber;

    ///時計の縁の色と描画スタイルを設定
    var outlineBrush = Paint()
      ..color = Colors.amber[50]
      ..style =
          PaintingStyle.stroke //stroke:縁をつくる、fill：塗り潰し、style設定しなければ塗り潰しになる
      ..strokeWidth = 16; //縁の太さ

    ///時計の中心の色
    var centerFillBrush = Paint()..color = Colors.amber[50];

    ///時計の針3本の色と描画スタイルを設定！
    var secHandBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.orangeAccent, Colors.pink])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round //ラインを丸くする
      ..strokeWidth = 8;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.lightBlue, Colors.lightGreen])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.green, Colors.yellow])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 14;

    ///時計回りの放射線状の線の描画スタイル
    var dashBrush = Paint()
      ..color = Colors.amber[50]
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    canvas.drawCircle(center, radius - 40, fillBrush); //時計の内側
    canvas.drawCircle(center, radius - 40, outlineBrush); //時計の縁

    ///時計の針のdrawLine終了点に使用
    ///80*はcenterからの距離を離すために必要(？)
    var hourHandX = centerX +
        60 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) *
                pi /
                180); //1時間後に急に針ががくっと動くのはやなので毎分0.5度足していく
    var hourHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    //時計の針:drawLine(開始点,終了点,描画スタイル)
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 12, centerFillBrush); //時計の中心点

    ///時計回りの放射線状の線
    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

//再描画される際に必要：true
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
