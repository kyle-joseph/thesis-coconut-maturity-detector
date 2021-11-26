import 'package:coconut_maturity_detector/services/schemas.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CocoDatabase {
  // ignore: prefer_typing_uninitialized_variables
  static var _database;

  //Initialize database and create necessary tables on create
  static Future openDb() async {
    _database = openDatabase(
      join(await getDatabasesPath(), 'coco_db.db'),
      onCreate: (db, version) {
        return createTables(db);
      },
      version: 1,
    );

    return _database;
  }

  //Funtion for tables creation
  static void createTables(Database db) {
    db.execute(
      'CREATE TABLE IF NOT EXISTS store(storeId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, storeName TEXT)',
    );
    db.execute(
      'CREATE TABLE IF NOT EXISTS staff(staffId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, staffName TEXT)',
    );
    db.execute(
      'CREATE TABLE IF NOT EXISTS collection(collectionId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, collectionName TEXT, createdAt TEXT, storeId INTEGER, staffId INTEGER)',
    );
    db.execute(
      'CREATE TABLE IF NOT EXISTS summary(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, collectionId INTEGER, prematureCount INTEGER, matureCount INTEGER, overmatureCount INTEGER)',
    );
  }

  // Retrieve data from db using custom query
  static Future read({
    required String tableName,
    List? columns,
    String? whereClause = '',
    List? arguments,
  }) async {
    final db = await openDb();

    // ignore: prefer_typing_uninitialized_variables
    var result;
    if (columns == null && arguments == null && whereClause == '') {
      result = await db.query(tableName);
    } else if (columns == null && arguments != null && whereClause != '') {
      result = await db.query(
        tableName,
        where: whereClause,
        whereArgs: arguments,
      );
    } else if (columns != null && arguments == null || whereClause == '') {
      result = await db.query(
        tableName,
        columns: columns,
      );
    } else {
      result = await db.query(
        tableName,
        columns: columns,
        where: whereClause,
        whereArgs: arguments,
      );
    }

    if (await result.length == 0) {
      return [];
    } else {
      var mappedResult = await getClassMap(tableName, result);
      return await mappedResult;
    }
  }

  static Future getClassMap(String tableName, var result) async {
    switch (tableName) {
      case 'store':
        {
          return List.generate(
            result.length,
            (i) {
              return Store(
                storeId: result[i]['storeId'],
                storeName: result[i]['storeName'],
              );
            },
          );
        }

      case 'staff':
        {
          return List.generate(
            result.length,
            (i) {
              return Staff(
                staffId: result[i]['staffId'],
                staffName: result[i]['staffName'],
              );
            },
          );
        }
      case 'collection':
        {
          return List.generate(
            result.length,
            (i) {
              return Collection(
                collectionId: result[i]['staffId'],
                collectionName: result[i]['staffName'],
                createdAt: result[i]['createdAt'],
                storeId: result[i]['storeId'],
                staffId: result[i]['staffId'],
              );
            },
          );
        }
      case 'summary':
        {
          return List.generate(
            result.length,
            (i) {
              return Summary(
                id: result[i]['id'],
                collectionId: result[i]['collectionId'],
                prematureCount: result[i]['prematureCount'],
                matureCount: result[i]['matureCount'],
                overmatureCount: result[i]['overmatureCount'],
              );
            },
          );
        }
    }
  }

  //Unified insert function for all tables
  static Future insert(
      {required var className, required String tableName}) async {
    final db = await openDb();
    var result = await db.insert(
      tableName,
      className.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return await result;
  }

  // Unified update function for all tables
  static Future update(
      {required var className,
      required String tableName,
      required String whereClause,
      required var arguments}) async {
    final db = await openDb();

    await db.update(
      tableName,
      className.toMap(),
      where: whereClause,
      whereArgs: arguments,
    );
  }

  static Future delete(
      {required String tableName,
      required String whereClause,
      required var arguments}) async {
    final db = await openDb();

    await db.delete(
      tableName,
      where: whereClause,
      whereArgs: arguments,
    );
  }
}
