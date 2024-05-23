import 'dart:math';

import 'package:flutter/material.dart';

Widget customText(
  BuildContext context,
  String text, {
  double size = 10.0,
  FontWeight fontWeight = FontWeight.w100,
  Color color = Colors.white,
  TextAlign textAlign = TextAlign.center,
  FontStyle fontStyle = FontStyle.normal,
}) {
  final double scaleFactor = ScaleSize.textScaleFactor(context);
  final double scaledFontSize = size * scaleFactor;

  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: scaledFontSize,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
      height: 1.6,
    ),
  );
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
