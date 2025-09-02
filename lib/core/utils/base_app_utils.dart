import 'dart:io';

import 'package:downloader/download_args.dart';
import 'package:downloader/downloader_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:flutter_base/core/extension/base_extensions.dart';
import 'BaseConstants.dart';


String joinParts(
  String part1, [
  String? part2,
  String? part3,
  String? part4,
  String? part5,
  String? part6,
  String? part7,
  String? part8,
  String? part9,
  String? part10,
  String? part11,
  String? part12,
  String? part13,
  String? part14,
  String? part15,
  String? part16,
]) {
  return join(
    part1,
    part2,
    part3,
    part4,
    part5,
    part6,
    part7,
    part8,
    part9,
    part10,
    part11,
    part12,
    part13,
    part14,
    part15,
    part16,
  );
}

bool isNumber(String? string) {
  if (string == null || string.isEmpty) {
    return false;
  }
  final number = int.tryParse(string);
  if (number == null) {
    return false;
  }
  return true;
}

String replaceEnglishNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], arabic[i]);
  }
  return input;
}

String replaceArabicNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(arabic[i], english[i]);
  }
  return input;
}

customLog(Object? object) {
  if (kDebugMode) {
    String text = "$object";
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(text)
        .forEach((match) => print("DebugPrintStatement : ${match.group(0)}"));
  }
}

customBaseLog(Object? object) {
  // if (kDebugMode) {
  //   String text = "$object";
  //   final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  //   pattern
  //       .allMatches(text)
  //       .forEach((match) => print("DebugPrintStatement : ${match.group(0)}"));
  // }
}

bool isFileExist({
  required String destinationDirPath,
  required String fileName,
}) {
  return DownloaderPlugin.isFileExist(
    destinationDirPath: destinationDirPath,
    fileName: fileName,
  );
}

bool isFileByArgsExist(DownloadArgs downloadArgs) {
  return DownloaderPlugin.isFileByArgsExist(downloadArgs);
}

bool isPlatformAndroid() {
  return Platform.isAndroid;
}

bool isPlatformIos() {
  return Platform.isIOS;
}
