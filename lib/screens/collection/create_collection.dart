import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/services/database.dart';
import 'package:coconut_maturity_detector/services/global_state.dart';
import 'package:coconut_maturity_detector/services/schemas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:toast/toast.dart';

// ignore: use_key_in_widget_constructors
class CreateCollection extends StatefulWidget {
  // const CreateCollection({Key? key}) : super(key: key);

  @override
  _CreateCollectionState createState() => _CreateCollectionState();
}

class _CreateCollectionState extends State<CreateCollection> {
  final TextEditingController _collectionController = TextEditingController();
  Color _textFieldColor = Colors.grey;
  bool validator = true;
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
                    controller: _collectionController,
                    decoration: InputDecoration(
                      fillColor: AppTheme.primaryColor,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: BorderSide(
                          color: AppTheme.primaryColor,
                          width: 2,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.primaryColor,
                          width: 2,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.errorColor,
                          width: 2,
                        ),
                      ),
                      labelText: 'Collection Name',
                      labelStyle: TextStyle(
                        color: _textFieldColor,
                      ),
                      errorText: validator ? null : 'This field required',
                      errorStyle: const TextStyle(
                        color: AppTheme.errorColor,
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
                      onPressed: () {
                        creatButtonPressed(context);
                      },
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

  void creatButtonPressed(BuildContext context) async {
    setState(() {
      validator = _collectionController.text.isEmpty ? false : true;
    });

    if (validator) {
      final store =
          Provider.of<ApplicationState>(context, listen: false).currentStore;
      final staff =
          Provider.of<ApplicationState>(context, listen: false).currentStaff;
      var newCollection = Collection(
          collectionName: _collectionController.text,
          storeId: store.storeId,
          staffId: staff.staffId,
          createdAt: DateTime.now().toIso8601String());
      var result = await CocoDatabase.insert(
          className: newCollection, tableName: 'collection');

      if (await result > 0) {
        Toast.show("Collection created successfully", context,
            duration: 3, gravity: Toast.BOTTOM);
        Navigator.pop(context);
      } else {
        Toast.show("Unsuccessful collection creation", context,
            duration: 3, gravity: Toast.BOTTOM);
        Navigator.pop(context);
      }
    }
  }
}
