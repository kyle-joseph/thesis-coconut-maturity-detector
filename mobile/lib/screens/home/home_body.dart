import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/collection/collection_list.dart';
import 'package:coconut_maturity_detector/screens/collection/create_collection.dart';
import 'package:coconut_maturity_detector/services/global_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                            ),
                            CreateCollection(),
                          ),
                          homeButton(
                            context,
                            "View Collections",
                            const Icon(
                              Icons.library_books,
                              size: 35,
                            ),
                            const CollectionListScreen(),
                          )
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

  Widget homeButton(BuildContext context, String label, Icon icon, var route) {
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
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => route,
            ),
          );
        },
      ),
    );
  }

  Widget homeStoreAndStaff(BuildContext context) {
    final store =
        Provider.of<ApplicationState>(context, listen: false).currentStore;
    final staff =
        Provider.of<ApplicationState>(context, listen: false).currentStaff;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 30,
          ),
          child: Column(
            children: [
              Text(
                store.storeName,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
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
              Text(
                staff.staffName,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
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
