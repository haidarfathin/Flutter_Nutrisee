import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  TextTheme textTheme({bool isDarkTheme = false}) => TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: AppColors.textBlack,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: AppColors.textBlack,
        ),
        headlineLarge: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        titleLarge:
            GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        titleMedium:
            GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.poppins(
          color: AppColors.textBlack,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: GoogleFonts.poppins(
          color: AppColors.textGray,
          fontSize: 10,
        ),
        labelSmall: GoogleFonts.poppins(
            fontSize: 8, fontWeight: FontWeight.w400, letterSpacing: 1.5),
      );

  AppBarTheme appBarTheme({bool isDarkTheme = false}) => const AppBarTheme(
        backgroundColor: AppColors.whiteBG,
        foregroundColor: AppColors.textBlack,
        centerTitle: true,
        elevation: 0,
      );

  CheckboxThemeData checkBoxTheme({bool isDarkTheme = false}) =>
      CheckboxThemeData(
        fillColor: WidgetStateProperty.all(AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        overlayColor: WidgetStateProperty.all(AppColors.textGray),
      );

  RadioThemeData radioTheme({bool isDarkTheme = false}) => RadioThemeData(
        fillColor: WidgetStateProperty.all(AppColors.primary),
      );

  InputDecorationTheme inputDecorationTheme({bool isDarkTheme = false}) =>
      InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.textGray,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.textGray,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.ancientSwatch,
          ),
        ),
        iconColor: AppColors.ancientSwatch,
        focusColor: AppColors.ancientSwatch,
      );

  static const marginHorizontal = 18.0;
  static const marginVertical = 20.0;

  BottomNavigationBarThemeData bottomNavigationBarTheme(
      {bool isDarkTheme = false}) {
    return BottomNavigationBarThemeData(
      backgroundColor: isDarkTheme ? Colors.black26 : Colors.white,
      unselectedItemColor:
          isDarkTheme ? Colors.blue.withOpacity(0.5) : Colors.grey,
    );
  }
}

extension SwitchTheme on AppTheme {
  ThemeData get light => ThemeData(
      textTheme: textTheme(),
      radioTheme: radioTheme(),
      checkboxTheme: checkBoxTheme(),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: appBarTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      bottomNavigationBarTheme: bottomNavigationBarTheme());

  ThemeData get dark => ThemeData(
        textTheme: textTheme(isDarkTheme: true),
        radioTheme: radioTheme(isDarkTheme: true),
        checkboxTheme: checkBoxTheme(isDarkTheme: true),
        scaffoldBackgroundColor: Colors.black26,
        appBarTheme: appBarTheme(isDarkTheme: true),
        inputDecorationTheme: inputDecorationTheme(isDarkTheme: true),
        bottomNavigationBarTheme: bottomNavigationBarTheme(isDarkTheme: true),
      );
}
