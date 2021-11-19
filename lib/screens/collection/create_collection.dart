import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class CreateCollection extends StatefulWidget {
  // const CreateCollection({Key? key}) : super(key: key);

  @override
  _CreateCollectionState createState() => _CreateCollectionState();
}

class _CreateCollectionState extends State<CreateCollection> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create Collection',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          backgroundColor: AppTheme.primaryColor,
        ),
        body: createCollectionBody(context),
      ),
    );
  }

  Widget createCollectionBody(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: -40,
          bottom: 0,
          child: Image.asset(
            'assets/images/coconut_tree.png',
            height: MediaQuery.of(context).size.height * 0.50,
          ),
        ),
        Positioned(
          left: -7,
          bottom: 0,
          child: Image.asset(
            'assets/images/coconut.png',
            height: MediaQuery.of(context).size.height * 0.22,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 15,
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: AppTheme.primaryColor,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: BorderSide(
                        color: AppTheme.primaryColor,
                        width: 3,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppTheme.primaryColor,
                        width: 3,
                      ),
                    ),
                    labelText: 'Collection Name',
                    labelStyle: TextStyle(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: ElevatedButton(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: AppTheme.errorColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: ElevatedButton(
                      child: const Text(
                        'Create',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: AppTheme.primaryColor,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
