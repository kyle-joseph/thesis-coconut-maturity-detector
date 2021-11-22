import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/detector/detector.dart';
import 'package:coconut_maturity_detector/screens/home/home.dart';
import 'package:coconut_maturity_detector/screens/image/image_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appTheme = AppTheme();

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Coconut Maturity Detector',
        theme: ThemeData(
          primaryColor: AppTheme.primaryColor,
          primaryColorLight: AppTheme.primaryColorLight,
          fontFamily: AppTheme.fontFamily,
        ),
        home: const ImageDetector(),
      ),
    );
  }
}
