import 'package:flutter/material.dart';
import 'package:qulock_app/clock_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        child: ClockView(),
      ),
    );
  }
}
