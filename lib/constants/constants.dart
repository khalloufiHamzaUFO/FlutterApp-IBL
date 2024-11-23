import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AppStyle{
  static Color bgColor = Color(0xFFE2E2FF);
  static Color mainColor = Color(0xFFE2E2FF);
  static Color accentColor = Color(0xFFE2E2FF);

  static List<Color> cardsColor = [
    Colors.white,
    Color(0xFFE2E2FF),
    Color(0xFFEDF285),
    Color(0xFF93ABD3),
    Color(0xFFB8DFD8),
    Color(0xFFF66B0E),
    Color(0xFFF8B400),
    Color(0xFFE9896A),
    Color(0xFFC0E218),
  ];
  static TextStyle mainTitle =
    GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.bold);

  static TextStyle mainContent =
    GoogleFonts.acme(fontSize: 16.0, fontWeight: FontWeight.normal);

  static TextStyle dateTitle =
    GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.normal);

}