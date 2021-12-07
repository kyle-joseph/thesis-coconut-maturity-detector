import 'package:audio_wave/audio_wave.dart';
import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/prediction/prediction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite_audio/tflite_audio.dart';

// ignore: use_key_in_widget_constructors
class AcousticBody extends StatefulWidget {
  @override
  _AcousticBodyState createState() => _AcousticBodyState();
}

class _AcousticBodyState extends State<AcousticBody> {
  String _sound = "";
  bool _recording = false;
  late Stream<Map<dynamic, dynamic>> result;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AudioWave(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 0.6,
            spacing: 3,
            animation: _recording,
            beatRate: const Duration(
              milliseconds: 150,
            ),
            bars: [
              AudioWaveBar(height: 10, color: AppTheme.primaryColor),
              AudioWaveBar(height: 30, color: AppTheme.primaryColor),
              AudioWaveBar(height: 70, color: AppTheme.primaryColor),
              AudioWaveBar(height: 40, color: AppTheme.primaryColor),
              AudioWaveBar(height: 20, color: AppTheme.primaryColor),
              AudioWaveBar(height: 10, color: AppTheme.primaryColor),
              AudioWaveBar(height: 30, color: AppTheme.primaryColor),
              AudioWaveBar(height: 70, color: AppTheme.primaryColor),
              AudioWaveBar(height: 40, color: AppTheme.primaryColor),
              AudioWaveBar(height: 20, color: AppTheme.primaryColor),
              AudioWaveBar(height: 10, color: AppTheme.primaryColor),
              AudioWaveBar(height: 30, color: AppTheme.primaryColor),
              AudioWaveBar(height: 70, color: AppTheme.primaryColor),
              AudioWaveBar(height: 40, color: AppTheme.primaryColor),
              AudioWaveBar(height: 20, color: AppTheme.primaryColor),
              AudioWaveBar(height: 10, color: AppTheme.primaryColor),
              AudioWaveBar(height: 30, color: AppTheme.primaryColor),
              AudioWaveBar(height: 70, color: AppTheme.primaryColor),
              AudioWaveBar(height: 40, color: AppTheme.primaryColor),
              AudioWaveBar(height: 20, color: AppTheme.primaryColor),
            ],
          ),
          // ignore: avoid_unnecessary_containers
          Container(
            child: ElevatedButton(
              child: const Icon(
                Icons.mic,
                size: 50,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                primary: AppTheme.primaryColor,
                onPrimary: Colors.greenAccent,
              ),
              onPressed: _recording ? null : () => {_recorder()},
            ),
          ),
        ],
      ),
    );
  }

  void _recorder() async {
    List finalResults = [];
    List recognitionResults = [];
    var recognition = '';
    double max = 0.0;
    int idx = 0;
    try {
      if (!_recording) {
        setState(() => _recording = true);

        result = TfliteAudio.startAudioRecognition(
          sampleRate: 44100,
          recordingLength: 44032,
          bufferSize: 22050,
          numOfInferences: 3,
        );
        // result = TfliteAudio.startAudioRecognition(
        //   inputType: 'rawAudio',
        //   sampleRate: 48000,
        //   recordingLength: 144000,
        //   bufferSize: 24000,
        //   numOfInferences: 1,
        // );
        result.listen((event) {
          recognition = event["recognitionResult"];
        }).onDone(
          () {
            List labels = [
              'Background Noise',
              'Mature',
              'Overmature',
              'Premature'
            ];
            setState(() => {_recording = false});
            recognition = recognition.replaceAll('[', '');
            recognition = recognition.replaceAll(']', '');
            recognitionResults = recognition.split(',');

            for (int x = 0; x < recognitionResults.length; x++) {
              finalResults.add(double.parse(recognitionResults[x]));
            }
            for (int x = 0; x < finalResults.length; x++) {
              if (finalResults[x] > max) {
                max = finalResults[x];
                idx = x;
              }
            }
            _sound = labels[idx];

            print(max);
            // _sound = recognition;

            // ignore: avoid_print
            print(finalResults);
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => PredictionScreen(
                  prediction: _sound,
                  percentage: (max * 100).toStringAsFixed(2),
                ),
              ),
            );
          },
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void loadModel() {
    TfliteAudio.loadModel(
      model: 'assets/model/coconut_acoustic_tm.tflite',
      label: 'assets/model/labels3.txt',
      inputType: 'rawAudio',
      outputRawScores: true,
      numThreads: 1,
      isAsset: true,
    );
  }
}
