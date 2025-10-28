import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  static TextTheme get light => TextTheme(
    displayLarge: GoogleFonts.manrope(fontSize: 32, fontWeight: FontWeight.bold),
    headlineLarge: GoogleFonts.manrope(fontSize: 24, fontWeight: FontWeight.w700),
    titleLarge: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w600),
    bodyLarge: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w500),
    bodyMedium: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w400),
    labelLarge: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w500),
  );

  static TextTheme get dark => TextTheme(
    displayLarge: GoogleFonts.manrope(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    headlineLarge: GoogleFonts.manrope(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
    titleLarge: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
    bodyLarge: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white70),
    bodyMedium: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white60),
    labelLarge: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
  );
}
