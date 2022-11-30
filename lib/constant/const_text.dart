

import 'package:flutter/material.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:google_fonts/google_fonts.dart';

const kBody13black400 = TextStyle(
  fontSize: 13,
  color: kLightBlack,
  overflow: TextOverflow.fade,
  fontWeight: FontWeight.w400,
);
const kBody14black600 = TextStyle(
  fontSize: 14,
  color: kTextBlack,
  overflow: TextOverflow.fade,
  fontWeight: FontWeight.w600,
);
const kBody14kWhite600 = TextStyle(
  fontSize: 14,
  color: kWhite,
  overflow: TextOverflow.fade,
  fontWeight: FontWeight.w600,
);

const KBody13white700=TextStyle(
    fontSize:13,
    color: kWhite,
    fontWeight: FontWeight.w700
);



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

