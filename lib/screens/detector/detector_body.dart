import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/image/image_detector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class DetectorBody extends StatefulWidget {
  @override
  _DetectorBodyState createState() => _DetectorBodyState();
}

class _DetectorBodyState extends State<DetectorBody> {
  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
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
            right: -40,
            bottom: 0,
            child: Image.asset(
              'assets/images/coconut_tree.png',
              height: MediaQuery.of(context).size.height * 0.50,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 5,
            child: Image.asset(
              'assets/images/coconut.png',
              height: MediaQuery.of(context).size.height * 0.17,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Column(
              children: [
                const Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    'Coconut Maturity Detector',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  flex: 6,
                  fit: FlexFit.tight,
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: detectorButton(
                          context,
                          'Image',
                          const Icon(
                            Icons.camera,
                            size: 40,
                          ),
                          ImageDetector(),
                        ),
                      ),
                      detectorButton(
                        context,
                        'Audio',
                        const Icon(
                          Icons.mic,
                          size: 40,
                        ),
                        ImageDetector(),
                      )
                    ],
                  )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget detectorButton(
      BuildContext context, String label, Icon icon, var route) {
    return ElevatedButton.icon(
      icon: icon,
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: AppTheme.primaryColor,
        minimumSize: const Size(165, 60),
      ),
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => route,
          ),
        );
      },
    );
  }
}
