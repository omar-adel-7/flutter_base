
import 'package:flutter/material.dart';

List<BoxShadow>? getShadow(BuildContext context,
    { required Color color,double? spreadRadius ,
      double? blurRadius , Offset? offset,
      BlurStyle? blurStyle,
      double? offsetY

    }) {
  return [
    BoxShadow(
        blurStyle: blurStyle ??  BlurStyle.outer,
        color: color ,
        spreadRadius: spreadRadius?? -1,
        blurRadius: blurRadius ?? 1,
        offset: offset ?? Offset(0, offsetY??2)
    ),
  ];
}


