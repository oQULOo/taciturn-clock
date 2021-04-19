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
      backgroundColor: Colors.blue,
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clock',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'Clock',
              style: TextStyle(color: Colors.white, fontSize: 64),
            ),
            Text(
              'Clock',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            ClockView(),
            Text(
              'Timezone',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.language, color: Colors.white),
                SizedBox(width: 16),
                Text(
                  'UTC',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
