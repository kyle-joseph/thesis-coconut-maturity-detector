import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class CreateCollection extends StatefulWidget {
  // const CreateCollection({Key? key}) : super(key: key);

  @override
  _CreateCollectionState createState() => _CreateCollectionState();
}

class _CreateCollectionState extends State<CreateCollection> {
  Color _textFieldColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Create Collection',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
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
            top: 30,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Focus(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: AppTheme.primaryColor,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: BorderSide(
                          color: AppTheme.primaryColor,
                          width: 3,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 3,
                        ),
                      ),
                      labelText: 'Collection Name',
                      labelStyle: TextStyle(
                        color: _textFieldColor,
                      ),
                    ),
                  ),
                  onFocusChange: (hasFocus) {
                    setState(() => _textFieldColor =
                        hasFocus ? AppTheme.primaryColor : Colors.grey);
                  },
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
