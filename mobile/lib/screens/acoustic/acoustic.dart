import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/acoustic/acoustic_body.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AcousticScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Acoustic Detector',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          backgroundColor: AppTheme.primaryColor,
        ),
        body: AcousticBody(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
