import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFont {
  final double fontsize;
  Color? color_;
  MyFont({required this.fontsize, this.color_});
  TextStyle getMainFont() {
    TextStyle mainFont = GoogleFonts.aclonica(
        textStyle: TextStyle(fontSize: fontsize, color: color_));
    return mainFont;
  }
}
