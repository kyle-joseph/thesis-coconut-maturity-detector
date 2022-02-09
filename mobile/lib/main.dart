import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/account/create_account.dart';
import 'package:coconut_maturity_detector/screens/home/home.dart';
import 'package:coconut_maturity_detector/services/database.dart';
import 'package:coconut_maturity_detector/services/global_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
  }

  Future<List> loadAccount() async {
    var storeResult = await CocoDatabase.read(tableName: 'store');
    var staffResult = await CocoDatabase.read(tableName: 'staff');

    if (await storeResult.isEmpty && await staffResult.isEmpty) {
      return [];
    }

    return [await storeResult, await staffResult];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      child: Listener(
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
                  var data = snapshot.data;
                  Provider.of<ApplicationState>(context, listen: false)
                      .setStoreAndStaffInfo(
                          storeId: data![0][0].storeId,
                          storeName: data[0][0].storeName,
                          staffId: data[1][0].staffId,
                          staffName: data[1][0].staffName);
                  return HomeScreen();
                }
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
