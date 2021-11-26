import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/collection_single/collection_summary.dart';
import 'package:coconut_maturity_detector/screens/detector/detector.dart';
import 'package:coconut_maturity_detector/services/database.dart';
import 'package:coconut_maturity_detector/services/global_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class CollectionListBody extends StatefulWidget {
  // const CollectionListBody({Key? key}) : super(key: key);

  @override
  _CollectionListBodyState createState() => _CollectionListBodyState();
}

class _CollectionListBodyState extends State<CollectionListBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
        left: 12,
        right: 12,
      ),
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List>(
        future: loadCollections(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return collectionList(snapshot.data![index]);
              },
            );
          }
          return const Center(
            child: Text(
              'No collections created.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 25,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List> loadCollections() async {
    var result = await CocoDatabase.read(tableName: 'collection');
    return await result;
  }

  Widget collectionList(var data) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
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
      child: Column(
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.collectionName ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Created: ${data.createdAt.split('T')[0] ?? ''}',
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          // ignore: avoid_unnecessary_containers
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: ElevatedButton(
                    child: const Text(
                      'Summary',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                      minimumSize: const Size(80, 30),
                    ),
                    onPressed: () {
                      Provider.of<ApplicationState>(context, listen: false)
                          .setCollectionId(data.collectionId);
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const CollectionSummaryScreen(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: ElevatedButton(
                    child: const Text(
                      'Detect',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppTheme.primaryColor,
                      minimumSize: const Size(80, 30),
                    ),
                    onPressed: () {
                      Provider.of<ApplicationState>(context, listen: false)
                          .setCollectionId(data.collectionId);
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => DetectorScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
