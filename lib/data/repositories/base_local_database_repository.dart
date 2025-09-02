import 'package:flutter_base/core/cache/base_hive_store.dart';
import 'package:flutter_base/data/databases/user/base_user_data_db.dart';

class BaseLocalDatabaseRepository {
  final BaseUserDataDB? baseUserDataDb;
  final BaseHiveStore baseHiveStore;

  BaseLocalDatabaseRepository({
    this.baseUserDataDb,
    required this.baseHiveStore,
  }) {
  }


}
