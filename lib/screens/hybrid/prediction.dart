// ignore_for_file: sized_box_for_whitespace, must_be_immutable, prefer_typing_uninitialized_variables, import_of_legacy_library_into_null_safe

import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/services/database.dart';
import 'package:coconut_maturity_detector/services/global_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

// ignore: use_key_in_widget_constructors
class HybridPredictionScreen extends StatefulWidget {
  @override
  State<HybridPredictionScreen> createState() => _HybridPredictionScreenState();
}

class _HybridPredictionScreenState extends State<HybridPredictionScreen> {
  var prediction = '';

  @override
  Widget build(BuildContext context) {
    calculateFinalPrediction(context);
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
          Positioned(
            right: -40,
            bottom: 0,
            child: Image.asset(
              'assets/images/coconut_tree.png',
              height: MediaQuery.of(context).size.height * 0.40,
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 35,
                  ),
                  child: Text(
                    'Prediction',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.13,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 35,
                  ),
                  child: Text(
                    prediction,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColorLight,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: ElevatedButton(
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: AppTheme.errorColor,
                          minimumSize: const Size(90, 40),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Provider.of<ApplicationState>(context, listen: false)
                              .clearHybridLabelsAndScores();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: ElevatedButton(
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: AppTheme.primaryColor,
                          minimumSize: const Size(90, 40),
                        ),
                        onPressed: () {
                          saveButtonPressed(context);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void calculateFinalPrediction(BuildContext context) {
    var hybridLabels = Provider.of<ApplicationState>(context, listen: false)
        .currentHybridLabels;
    var hybridScores = Provider.of<ApplicationState>(context, listen: false)
        .currentHybridScores;
    List imageWeights = [0.9, 0.7, 0.9];
    List acousticWeights = [1.0, 0.9, 1.0];
    List weightedScores = [];

    double imgWeight = 0.0;
    double acsWeight = 0.0;

    double maxScore = 0.0;
    int maxIdx = 0;

    switch (hybridLabels[0]) {
      case 'Premature':
        imgWeight = imageWeights[0];
        break;
      case 'Mature':
        imgWeight = imageWeights[1];
        break;
      case 'Overmature':
        imgWeight = imageWeights[2];
        break;
    }

    switch (hybridLabels[1]) {
      case 'Premature':
        acsWeight = acousticWeights[0];
        break;
      case 'Mature':
        acsWeight = acousticWeights[1];
        break;
      case 'Overmature':
        acsWeight = acousticWeights[2];
        break;
    }

    weightedScores.add(hybridScores[0] * imgWeight);
    weightedScores.add(hybridScores[1] * acsWeight);

    for (int x = 0; x < weightedScores.length; x++) {
      if (weightedScores[x] > maxScore) {
        maxScore = weightedScores[x];
        maxIdx = x;
      }
    }

    setState(() {
      prediction = hybridLabels[maxIdx];
    });
  }

  void saveButtonPressed(BuildContext context) async {
    final collectionId = Provider.of<ApplicationState>(context, listen: false)
        .currentCollectionId;

    String toUpdate = '';
    switch (prediction) {
      case 'Background Noise':
        Toast.show(
          "Cannot save 'Background' prediction",
          context,
          duration: 3,
          gravity: Toast.BOTTOM,
          backgroundColor: AppTheme.errorColor,
        );
        break;
      case 'Premature':
        toUpdate = 'prematureCount';
        break;
      case 'Mature':
        toUpdate = 'matureCount';
        break;
      case 'Overmature':
        toUpdate = 'overmatureCount';
        break;
    }

    String sql =
        "UPDATE summary SET $toUpdate = $toUpdate + 1 WHERE collectionId = ?";
    List arguments = [collectionId];

    var result = await CocoDatabase.update(sql: sql, arguments: arguments);

    if (await result > 0) {
      Toast.show(
        "Prediction saved successfully",
        context,
        duration: 3,
        gravity: Toast.BOTTOM,
      );
      Navigator.pop(context);
      Provider.of<ApplicationState>(context, listen: false)
          .clearHybridLabelsAndScores();
    } else {
      Toast.show(
        "Prediction saving was unsuccessful",
        context,
        duration: 3,
        gravity: Toast.BOTTOM,
        backgroundColor: AppTheme.errorColor,
      );
      Navigator.pop(context);
    }
  }
}
