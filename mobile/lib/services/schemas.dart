class Store {
  final int? storeId;
  final String storeName;

  Store({
    this.storeId,
    required this.storeName,
  });

  Map<String, dynamic> toMap() {
    return {
      'storeId': storeId,
      'storeName': storeName,
    };
  }
}

class Staff {
  final int? staffId;
  final String staffName;

  Staff({
    this.staffId,
    required this.staffName,
  });

  Map<String, dynamic> toMap() {
    return {
      'staffId': staffId,
      'staffName': staffName,
    };
  }
}

class Collection {
  final int? collectionId;
  final int? storeId;
  final int? staffId;
  final String collectionName;
  // ignore: prefer_typing_uninitialized_variables
  var createdAt;

  Collection({
    this.collectionId,
    required this.collectionName,
    required this.storeId,
    required this.staffId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'collectionId': collectionId,
      'collectionName': collectionName,
      'storeId': storeId,
      'staffId': staffId,
      'createdAt': createdAt,
    };
  }
}

class Summary {
  final int? id;
  final int collectionId;
  final int prematureCount;
  final int matureCount;
  final int overmatureCount;

  Summary({
    this.id,
    required this.collectionId,
    required this.prematureCount,
    required this.matureCount,
    required this.overmatureCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'collectionId': collectionId,
      'prematureCount': prematureCount,
      'matureCount': matureCount,
      'overmatureCount': overmatureCount,
    };
  }
}
