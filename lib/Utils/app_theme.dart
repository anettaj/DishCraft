import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme{
  static ThemeData themeData=ThemeData(
    scaffoldBackgroundColor: bgColor,
    cardColor:  cardColor,
    textTheme: textTheme
  );

  static TextTheme textTheme=TextTheme(
      bodyLarge: GoogleFonts.aBeeZee(
        color: white,

      ),
      titleLarge: GoogleFonts.aBeeZee(
        color: white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.notoSans(
        color: white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    labelSmall: GoogleFonts.aBeeZee(
      color: grey,
      fontSize: 14,
    ),
      displayMedium: GoogleFonts.poppins(
          fontSize: 14,
          color: lightGoldenRod
      ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 10,
      color: lightGoldenRod
    ),
    bodyMedium:  GoogleFonts.aBeeZee(
      color: white,
      fontSize: 14,
    ),
  );

}