import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_c13_sun/theme/theme.dart';

class DarkTheme extends BaseTheme {
  @override
   Color get backgroundColor => const Color(0xFF101127);

  @override
   Color get primaryColor => const Color(0xFF5669FF);

  @override
   Color get textColor => const Color(0xFFF4EBDC);

  @override
   ThemeData get themeData => ThemeData(
    focusColor: primaryColor,
    primaryColor: primaryColor,
    hintColor: backgroundColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: backgroundColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleSmall: GoogleFonts.inter(
        fontSize: 16,
        color: primaryColor,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 20,
        color: primaryColor,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 26,
        color: primaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
