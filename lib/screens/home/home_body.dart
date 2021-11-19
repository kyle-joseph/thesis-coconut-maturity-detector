import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            color: AppTheme.primaryColor,
          ),
          Column(
            children: [
              homeHeader(context),
              homeBody(context),
            ],
          )
        ],
      ),
    );
  }

  Widget homeHeader(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text(
            'Coconut Maturity Detector',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget homeBody(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.white,
        ),
        child: Stack(
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
            SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.33,
                      child: homeStoreAndStaff(context),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(
                        top: 25,
                      ),
                      child: Column(
                        children: [
                          homeButton(
                              context,
                              "New Collection",
                              const Icon(
                                Icons.add,
                                size: 35,
                              )),
                          homeButton(
                              context,
                              "View Collections",
                              const Icon(
                                Icons.library_books,
                                size: 35,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget homeButton(BuildContext context, String label, Icon icon) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 25,
      ),
      child: ElevatedButton.icon(
        icon: icon,
        label: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          primary: AppTheme.primaryColor,
          minimumSize: const Size(228, 60),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget homeStoreAndStaff(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 30,
          ),
          child: Column(
            children: [
              const Text(
                "John Doe Buko",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.store,
                    color: AppTheme.primaryColorLight,
                  ),
                  Text(
                    " Store",
                    style: TextStyle(
                      color: AppTheme.primaryColorLight,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        // ignore: avoid_unnecessary_containers
        Container(
          child: Column(
            children: [
              const Text(
                "Maria Doe",
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.person,
                    color: AppTheme.primaryColorLight,
                  ),
                  Text(
                    " Staff",
                    style: TextStyle(
                      color: AppTheme.primaryColorLight,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
