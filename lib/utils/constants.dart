import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextSize {
  xsm,
  sm,
  base,
  lg,
  xl,
  xxl,
}

  const Map<TextSize, double> textSizeMap = {
    TextSize.xsm: 10,
    TextSize.base: 14,
    TextSize.sm: 12.0,
    TextSize.lg: 16.0,
    TextSize.xl: 18.0,
    TextSize.xxl: 24.0,
  };
class Constants {
  static TextStyle customTextStyle({
    Color color = Colors.black,
    TextSize textSize = TextSize.base,
    FontWeight fontWeight = FontWeight.normal
  }) {
    double fontSize = textSizeMap[textSize] ?? 14.0; // Default to "xl" (18.0)
    return GoogleFonts.firaSans(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight
    );
  }
}
