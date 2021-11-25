import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/account/create_account.dart';
import 'package:coconut_maturity_detector/screens/home/home.dart';
import 'package:coconut_maturity_detector/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List> storeResult;

  @override
  void initState() {
    super.initState();
    loadAccount();
  }

  void loadAccount() async {
    storeResult = await CocoDatabase.read(tableName: 'store');
  }

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
        home: FutureBuilder(
          future: storeResult,
          builder: (context, snapshot) {
            // if (snapshot.hasData && storeResult.length == 0) {}
          },
        ),
      ),
    );
  }
}
