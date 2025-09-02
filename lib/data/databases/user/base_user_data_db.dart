import 'package:sqflite_sqlcipher/sqflite.dart';

import '../base_database.dart';

abstract class BaseUserDataDB extends BaseDatabase {


  @override
  String getDbName() {
    return 'user_data.db';
  }

  @override
  bool isUserDatabase() {
    return true;
  }

  @override
  int getUserDataDbVersion() {
    return 1;
  }

  Future<Database?> get database {
    return getDatabase("");
  }

  @override
  Future<void> onCreate(Database db, int version) async {
    // Run the CREATE  TABLE statement on the database.
  }

}
