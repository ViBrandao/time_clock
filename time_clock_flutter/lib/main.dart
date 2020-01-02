import 'package:flutter/material.dart';
import 'package:time_clock_flutter/screens/dashboard.dart';

void main() => runApp(TimeClockApp());

class TimeClockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff1a237e),
        buttonTheme: ButtonThemeData (
          buttonColor: Color(0xff6f79a8),
          textTheme: ButtonTextTheme.primary
        ),
      ),
      home: Dashboard(),
    );
  }
}
