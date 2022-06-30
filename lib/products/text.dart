import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectText {
  static Text rText(
          {required String text,
          required double fontSize,
          Color? color = Colors.white,
          FontWeight? fontWeight = FontWeight.w300,
          double? letterSpacing = 0,
          TextDecoration? decoration = TextDecoration.none,
          int? maxLines = 10,
          TextAlign? textAlign = TextAlign.center}) =>
      Text(text,maxLines: maxLines, textAlign: textAlign,
          style: GoogleFonts.raleway(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              decoration: decoration,));
              
}
