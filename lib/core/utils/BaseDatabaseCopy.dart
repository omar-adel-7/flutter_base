import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_base/core/utils/BaseConstants.dart';
import 'package:flutter_base/core/utils/base_app_utils.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:flutter/services.dart';

import '../../BaseConfiguration.dart';

class BaseDatabaseCopy {

  Future<void> getAssetsDB({
    required String name,
    String? assetsPath ,
    String? assetsNestedfolder,
    String? folder,
    required bool copiedNewDatabases,
  }) async {
    assetsNestedfolder =
        assetsNestedfolder ?? BaseConfiguration().databasesAssetsFolderName;
    var databasesPath = await getDatabasesPath();
    var dbPath = folder == null
        ? join(databasesPath, name)
        : join(databasesPath, folder, name);
    var exists = await databaseExists(dbPath);
    if (!exists) {
      await copyFromDbAssets(
        assetsPath: assetsPath,
        dbPath: dbPath,
        name: assetsNestedfolder.isNotEmpty
            ? "$assetsNestedfolder/$name"
            : name,
      );
    } else {
      if (!copiedNewDatabases) {
        await deleteDatabase(dbPath);
        try {
          await copyFromDbAssets(
            assetsPath: assetsPath,
            dbPath: dbPath,
            name: assetsNestedfolder.isNotEmpty
                ? "$assetsNestedfolder/$name"
                : name,
          );
        } catch (e) {
          customBaseLog('copyNewDatabasesIfNeeded error $e');
        }
      }
    }
    await openDatabase(
      dbPath,
      password: BaseConfiguration().baseDatabasesPassword,
    );
  }

  copyFromDbAssets({
    String? assetsPath ,
    required String dbPath,
    required String name,
  }) async {
      assetsPath = assetsPath ?? BaseConstants.assetsFolder;
    try {
      await Directory(dirname(dbPath)).create(recursive: true);
    } catch (e) {
      customBaseLog("copyFromDbAssets Error $e");
    }
    var data = await rootBundle.load(join(assetsPath, name));
    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    await File(dbPath).writeAsBytes(bytes, flush: true);
  }
}
