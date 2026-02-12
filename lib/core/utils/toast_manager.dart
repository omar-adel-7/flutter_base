import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

class ToastManger {
  static showToast(
      String message, {
        Toast? toastLength,
        int timeInSecForIosWeb = 2,
        double? fontSize,
        String? fontAsset,
        ToastGravity? gravity,
        Color? backgroundColor,
        Color? textColor,
      }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength ?? Toast.LENGTH_LONG,
      timeInSecForIosWeb: timeInSecForIosWeb,
      fontSize: fontSize ?? 16.0,
      fontAsset: fontAsset,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }
}
