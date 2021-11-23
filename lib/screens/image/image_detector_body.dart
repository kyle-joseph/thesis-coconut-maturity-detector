// ignore_for_file: non_constant_identifier_names, duplicate_ignore, avoid_print

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/prediction/prediction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';

// ignore: use_key_in_widget_constructors
class ImageDetectorBody extends StatefulWidget {
  @override
  _ImageDetectorBodyState createState() => _ImageDetectorBodyState();
}

class _ImageDetectorBodyState extends State<ImageDetectorBody> {
  late CameraController _cameraController;
  late Future<void> _initCameraFuture;
  late List predictions;
  bool _flashOn = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: availableCameras(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error getting cameras');
        } else if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          CameraDescription camera =
              (snapshot.data as List<CameraDescription>).first;
          return imageDetectorBody(context, camera);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget imageDetectorBody(BuildContext context, CameraDescription camera) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: homeBody(context, camera),
    );
  }

  FutureBuilder homeBody(BuildContext context, CameraDescription camera) {
    _cameraController = CameraController(camera, ResolutionPreset.high);
    _initCameraFuture = _cameraController.initialize();
    final _screenSize = MediaQuery.of(context).size;

    return FutureBuilder<void>(
      future: _initCameraFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Camera error'));
        } else if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return Stack(
            children: [
              // ignore: avoid_unnecessary_containers
              Container(
                child: Transform.scale(
                  scale: 1 /
                      (_cameraController.value.aspectRatio *
                          _screenSize.aspectRatio),
                  alignment: Alignment.center,
                  child: CameraPreview(_cameraController),
                ),
              ),
              Center(
                child: Container(
                  width: 224,
                  height: 224,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff12DF9A),
                      width: 3,
                    ),
                  ),
                ),
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: AppTheme.primaryColor,
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Place the coconut inside the square.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: ElevatedButton(
                              child: Icon(
                                _flashOn ? Icons.flash_on : Icons.flash_off,
                                size: 25,
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                                primary: AppTheme.primaryColor,
                                onPrimary: Colors.greenAccent,
                              ),
                              onPressed: () {
                                setState(() => _flashOn = !_flashOn);
                              },
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: ElevatedButton(
                              child: const Icon(
                                Icons.camera,
                                size: 50,
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                                primary: AppTheme.primaryColor,
                                onPrimary: Colors.greenAccent,
                              ),
                              onPressed: () async {
                                _cameraController.setFlashMode(_flashOn
                                    ? FlashMode.always
                                    : FlashMode.off);
                                await captureImage(context);
                              },
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Container(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future captureImage(BuildContext context) async {
    // ignore: duplicate_ignore
    try {
      await _initCameraFuture;
      // ignore: unused_local_variable
      final imagePath = join(
        (await getExternalStorageDirectory())!.path,
        '${DateTime.now()}.jpg',
      );
      final image = await _cameraController.takePicture();
      ImageProperties properties =
          await FlutterNativeImage.getImageProperties(image.path);
      var size = 224 * 2;
      // ignore: non_constant_identifier_names
      var offset_x = (properties.width! - size) / 2;
      var offset_y = (properties.height! - size) / 2;

      File croppedFile = await FlutterNativeImage.cropImage(image.path,
          offset_x.toInt(), offset_y.toInt(), size.toInt(), size.toInt());

      // croppedFile.copy(imagePath);
      // image.saveTo(imagePath);

      var prediction = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 3,
        threshold: 0.4,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      await croppedFile.delete();
      print(prediction);

      await Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => PredictionScreen(
            prediction: prediction![0]["label"],
          ),
        ),
      );
      // ignore: avoid_print
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future loadModel() async {
    Tflite.close();
    var res = await Tflite.loadModel(
        model: "assets/model/coconut_image_augmented.tflite",
        labels: "assets/model/labels.txt");
    // ignore: avoid_print
    print("Hello World: $res");
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
