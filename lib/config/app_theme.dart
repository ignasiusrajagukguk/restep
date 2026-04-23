import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.inter().fontFamily,
    textTheme: const TextTheme(
      bodySmall: TextStyle(),
      bodyMedium: TextStyle(),
      bodyLarge: TextStyle(),
    ).apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
    scaffoldBackgroundColor: AppColor.lightBG,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
    ),
  );
}
