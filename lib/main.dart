import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appTheme = AppTheme();

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coconut Maturity Detector',
      theme: ThemeData(
        primaryColor: AppTheme.primaryColor,
        primaryColorLight: AppTheme.primaryColorLight,
        fontFamily: AppTheme.fontFamily,
      ),
      home: HomeScreen(),
    );
  }
}
