import 'package:flutter_base/core/utils/base_app_utils.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';


abstract class BaseDatabase {
  late String dbAppendedPath;

  // Singleton pattern
  Database? db;

  Future<Database?> getDatabase(
      String dbAppendedPath) async {
    if (db != null) return db;
    // Initialize the DB first time it is accessed
    this.dbAppendedPath = dbAppendedPath;
    db = await _initDB();
    return db;
  }

  Future<Database?> _initDB() async {
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    String path = "";
    if (dbAppendedPath.isEmpty) {
      path = joinParts(await getDatabasesPath(), getDbName());
    } else {
      path = joinParts(await getDatabasesPath(), dbAppendedPath, getDbName());
    }
    if(isUserDatabase()){
      if (getDbPassword() != null) {
        return await openDatabase(path,
            onCreate: onCreate,
            onUpgrade: (db, oldVersion, newVersion) =>
                onUpgrade(db, oldVersion, newVersion),
            version: getUserDataDbVersion(),
            password: getDbPassword());
      } else {
        return await openDatabase(
          path,
          onCreate: onCreate,
          onUpgrade: (db, oldVersion, newVersion) =>
              onUpgrade(db, oldVersion, newVersion),
          version: getUserDataDbVersion(),
        );
      }
    }
    else
      {
        if (await databaseExists(path)) {
          if (getDbPassword() != null) {
            return await openDatabase(path, password: getDbPassword());
          } else {
            return await openDatabase(path);
          }
        }
      }
    return null ;
  }

  bool isUserDatabase() {
    return false;
  }

  String getDbName();

  String? getDbPassword(){
    return null ;
  }

  int getUserDataDbVersion() {
    return 1;
  }

  Future<void> onCreate(Database db, int version) async {

  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
  }
}
