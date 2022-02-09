// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:coconut_maturity_detector/components/theme.dart';
import 'package:coconut_maturity_detector/screens/collection_single/collection_summary.dart';
import 'package:coconut_maturity_detector/screens/detector/detector.dart';
import 'package:coconut_maturity_detector/services/database.dart';
import 'package:coconut_maturity_detector/services/global_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

// ignore: use_key_in_widget_constructors
class CollectionListBody extends StatefulWidget {
  // const CollectionListBody({Key? key}) : super(key: key);

  @override
  _CollectionListBodyState createState() => _CollectionListBodyState();
}

class _CollectionListBodyState extends State<CollectionListBody> {
  Future? collections;
  bool deleteCollection = false;

  @override
  void initState() {
    super.initState();
    loadCollections();
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
      child: FutureBuilder<dynamic>(
        future: collections,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            data = data.reversed.toList();
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return collectionList(data![index]);
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

  void loadCollections() {
    var result = CocoDatabase.read(tableName: 'collection');
    setState(() {
      collections = result;
    });
  }

  void collectionDeleteById(BuildContext context, var id) async {
    await showDeleteDialog(context);
    if (deleteCollection) {
      var collectionDelete = await CocoDatabase.delete(
          tableName: 'collection',
          whereClause: 'collectionId = ?',
          arguments: [id]);
      var summaryDelete = await CocoDatabase.delete(
          tableName: 'summary',
          whereClause: 'collectionId = ?',
          arguments: [id]);

      if (await collectionDelete > 0 && await summaryDelete > 0) {
        loadCollections();
        deleteCollection = false;
        Toast.show(
          "Collection deleted successfully",
          context,
          duration: 3,
          gravity: Toast.BOTTOM,
        );
      }
    }
  }

  Future<void> showDeleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Collection Delete'),
        content: const Text('Do you want to delete collection?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              deleteCollection = false;
              Navigator.pop(context, 'No');
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              deleteCollection = true;
              Navigator.pop(context, 'Yes');
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
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
            margin: const EdgeInsets.only(
              bottom: 7,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.collectionName ?? '',
                  style: const TextStyle(
                    fontSize: 17,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ignore: avoid_unnecessary_containers
              Container(
                child: Row(
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
                          Provider.of<ApplicationState>(context, listen: false)
                              .setCollectionName(data.collectionName);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  const CollectionSummaryScreen(),
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
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: AppTheme.errorColor,
                  size: 30,
                ),
                onPressed: () {
                  collectionDeleteById(context, data.collectionId);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
