import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  late final TextEditingController _storeNameController =
      TextEditingController();
  late final TextEditingController _staffNameController =
      TextEditingController();
  // ignore: prefer_final_fields
  bool _validatedStoreName = true;
  // ignore: prefer_final_fields
  bool _validatedStaffName = true;

  @override
  void dispose() {
    _storeNameController.dispose();
    _staffNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: createAccountBody(context),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget createAccountBody(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/create_background_1.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/create_background_2.png',
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            left: 5,
            bottom: 10,
            child: Image.asset(
              'assets/images/coconut.png',
              height: MediaQuery.of(context).size.height * 0.17,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.18,
              left: 25,
              right: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.08),
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // ignore: avoid_unnecessary_containers
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: registerTextField(context, "Business/Store Name",
                            _storeNameController, _validatedStoreName),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: registerTextField(context, "Staff Name",
                            _staffNameController, _validatedStaffName),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            child: const Text(
                              'Create',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: AppTheme.primaryColor,
                              minimumSize: const Size(100, 45),
                            ),
                            onPressed: () {
                              createButtonPressed();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void createButtonPressed() {
    setState(() {
      _validatedStoreName = _storeNameController.text.isEmpty ? false : true;
      _validatedStaffName = _staffNameController.text.isEmpty ? false : true;
    });
  }

  Widget registerTextField(
      BuildContext context, String label, var controller, bool validator) {
    return TextField(
      controller: controller,
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
        labelText: label,
        errorText: validator ? null : 'This field should not be empty',
        errorStyle: const TextStyle(
          color: AppTheme.errorColor,
        ),
        floatingLabelStyle: const TextStyle(
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }
}
