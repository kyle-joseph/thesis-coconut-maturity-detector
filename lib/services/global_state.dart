import 'package:coconut_maturity_detector/services/schemas.dart';
import 'package:flutter/cupertino.dart';

class ApplicationState extends ChangeNotifier {
  // ignore: prefer_typing_uninitialized_variables
  var store = Store(storeName: '');
  // ignore: prefer_typing_uninitialized_variables
  var staff = Staff(staffName: '');

  late int collectionId;

  Store get currentStore => store;

  Staff get currentStaff => staff;

  int get currentCollectionId => collectionId;

  void setStoreAndStaffInfo(
      {required var storeId,
      required var storeName,
      required var staffId,
      required var staffName}) {
    store = Store(storeId: storeId, storeName: storeName);
    staff = Staff(staffId: storeId, staffName: staffName);
  }

  void setCollectionId(int id) {
    collectionId = id;
  }
}
