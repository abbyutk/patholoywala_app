import 'package:flutter/material.dart';

class StaticStyle {
  static getAdaptiveSized(double heigh, double size) {
    return heigh * size;
  }

  static TextStyle textStyle(
          {Color? fontColor,
          FontWeight fontWeight = FontWeight.normal,
          TextDecoration? textDecoration,
          TextOverflow textOverflow = TextOverflow.ellipsis,
          required double fontSide,
          required double height}) =>
      TextStyle(
        color: fontColor ?? Colors.black,
        fontWeight: fontWeight,
        fontFamily: "Sarabun",
        decoration: textDecoration,
        overflow: textOverflow,
        fontSize: getAdaptiveSized(height, fontSide),
      );
}
