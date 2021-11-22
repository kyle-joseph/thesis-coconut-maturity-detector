import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/image/image_detector_body.dart';
import 'package:flutter/material.dart';

class ImageDetector extends StatelessWidget {
  const ImageDetector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Image Detector',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          backgroundColor: AppTheme.primaryColor,
        ),
        body: ImageDetectorBody(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
