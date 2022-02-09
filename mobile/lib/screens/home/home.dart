import 'package:coconut_maturity_detector/screens/home/home_body.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: HomeBody(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
