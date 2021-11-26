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
  @override
  void initState() {
    super.initState();
    loadAccount();
  }

  Future<List> loadAccount() async {
    var storeResult = await CocoDatabase.read(tableName: 'store');
    return storeResult;
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
        home: FutureBuilder<List>(
          future: loadAccount(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return CreateAccount();
              } else {
                return HomeScreen();
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
