import 'dart:io';

import 'package:downloader/download_args.dart';
import 'package:downloader/downloader_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';

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

bool isFileExist({
  required String destinationPath,
  required String fileName,
}) {
  return DownloaderPlugin.isFileExist(
    destinationPath: destinationPath,
    fileName: fileName,
  );
}

bool isFileByArgsExist(DownloadArgs downloadArgs) {
  return DownloaderPlugin.isFileByArgsExist(downloadArgs);
}


Future<bool> hasInternetToUrl(String url) async {
  try {
    final uri = Uri.parse(url);
    var response = await head(uri)
        .timeout(const Duration(seconds: 3));

    customLog('hasInternetToUrl head response.statusCode ${response.statusCode}');

    // لو السيرفر لا يدعم HEAD أو أعطى 4xx
    if (response.statusCode >= 400) {
      response = await get(
        uri,
        headers: {
          "Range": "bytes=0-0",
          "Connection": "close",
        },
      ).timeout(const Duration(seconds: 3));

      customLog('hasInternetToUrl get response.statusCode >= 400  ${response.statusCode}');
    }
    customLog('hasInternetToUrl final response.statusCode ${response.statusCode}');
    // النجاح = السيرفر رد أصلاً
    return response.statusCode < 500;
  } catch (e) {
    customLog('hasInternetToUrl catch exception $e');
    return false;
  }
}


Future<bool> hasInternetToFamousUrl() async {
  try {
    final response = await get(
      Uri.parse("https://clients3.google.com/generate_204"),
    ).timeout(const Duration(milliseconds: 2500));
    return response.statusCode == 204;
  } catch (_) {
    return false;
  }
}

bool isPlatformAndroid() {
  return Platform.isAndroid;
}

bool isPlatformIos() {
  return Platform.isIOS;
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