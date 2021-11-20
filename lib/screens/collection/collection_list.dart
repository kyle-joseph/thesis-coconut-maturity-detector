import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/collection/collection_list_body.dart';
import 'package:flutter/material.dart';

class CollectionListScreen extends StatelessWidget {
  const CollectionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Collections List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          backgroundColor: AppTheme.primaryColor,
        ),
        body: CollectionListBody(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
