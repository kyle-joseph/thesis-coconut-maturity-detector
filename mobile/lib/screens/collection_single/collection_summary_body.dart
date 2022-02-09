import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/services/database.dart';
import 'package:coconut_maturity_detector/services/global_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class CollectionSummaryBody extends StatefulWidget {
  @override
  _CollectionSummaryBodyState createState() => _CollectionSummaryBodyState();
}

class _CollectionSummaryBodyState extends State<CollectionSummaryBody> {
  @override
  Widget build(BuildContext context) {
    final collectionId = Provider.of<ApplicationState>(context, listen: false)
        .currentCollectionId;
    final collectionName = Provider.of<ApplicationState>(context, listen: false)
        .currentCollectionName;

    // ignore: sized_box_for_whitespace
    return Container(
      height: MediaQuery.of(context).size.height,
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
              left: 20,
              right: 20,
            ),
            width: MediaQuery.of(context).size.width,
            child: Container(
                // height: MediaQuery.of(context).size.height * 0.5,
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: FutureBuilder<List>(
                  future: loadSummary(collectionId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 25,
                            ),
                            child: Text(
                              collectionName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          summaryCard('Premature', '(Malauhog)',
                              data![0].prematureCount ?? 0),
                          summaryCard('Mature', '(Malakanin)',
                              data[0].matureCount ?? 0),
                          summaryCard('Overmature', '(Malakatad)',
                              data[0].overmatureCount ?? 0),
                        ],
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }

  Future<List> loadSummary(var id) async {
    var result = await CocoDatabase.read(
        tableName: 'summary', whereClause: 'collectionId = ?', arguments: [id]);
    return await result;
  }

  Widget summaryCard(String label, String altLabel, int count) {
    return Container(
      height: 65,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  altLabel,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Text(
            count.toString(),
            style: const TextStyle(
              color: AppTheme.primaryColorLight,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
