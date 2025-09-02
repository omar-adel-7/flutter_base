import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';

import 'BaseConstants.dart';
import 'base_app_utils.dart';


Future<void> copyAssetDrawableToAppFolder(
{required String destinationFilePath, required String assetFileName,String? assetsPath}
    ) async {
  try {
    await Directory(dirname(destinationFilePath)).create(recursive: true);
  } catch (_) {}
  // Copy from asset
  assetsPath = assetsPath ?? BaseConstants.assetsFolder;
  final String assetsDrawablesFolder = "$assetsPath/drawables/";
  ByteData sourceData =
      await rootBundle.load(joinParts(assetsDrawablesFolder, assetFileName));
  List<int> sourceBytes = sourceData.buffer
      .asUint8List(sourceData.offsetInBytes, sourceData.lengthInBytes);
  // Write and flush the bytes written
  await File(destinationFilePath).writeAsBytes(sourceBytes, flush: true);
}
