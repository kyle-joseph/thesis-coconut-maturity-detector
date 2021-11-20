import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/collection_single/collection_summary_body.dart';
import 'package:flutter/material.dart';

class CollectionSummaryScreen extends StatelessWidget {
  const CollectionSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Collection Summary',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          backgroundColor: AppTheme.primaryColor,
        ),
        body: CollectionSummaryBody(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
