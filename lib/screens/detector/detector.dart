import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/detector/detector_body.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class DetectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Maturity Detector',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          backgroundColor: AppTheme.primaryColor,
        ),
        body: DetectorBody(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
