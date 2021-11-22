import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:flutter/material.dart';

class PredictionScreen extends StatelessWidget {
  var prediction;
  // ignore: use_key_in_widget_constructors
  PredictionScreen({required this.prediction});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Prediction',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          elevation: 0,
          backgroundColor: AppTheme.primaryColor,
        ),
        body: predictionBody(context),
        resizeToAvoidBottomInset: false,
      ),
    );
    ;
  }

  Widget predictionBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/create_background_2.png',
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/create_background_1.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
          Positioned(
            left: 20,
            top: 10,
            child: Image.asset(
              'assets/images/coconut.png',
              height: MediaQuery.of(context).size.height * 0.17,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.2,
              left: 15,
              right: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Prediction',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.13,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                Text(
                  prediction,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.11,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColorLight,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
