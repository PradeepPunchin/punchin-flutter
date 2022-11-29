import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFonts {
  static TextStyle getMultipleStyle(
      double size, Color color, FontWeight fontWeight) {
    return GoogleFonts.nunito(
        fontWeight: fontWeight,
        fontSize: size,
        color: color,
        fontStyle: FontStyle.normal);
  }
}
