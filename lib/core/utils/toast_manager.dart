import 'package:fluttertoast/fluttertoast.dart';

class ToastManger{
  static showToast(String message,[Toast? toastLength]) {
    toastLength = toastLength ?? Toast.LENGTH_LONG;
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
    );
  }
}