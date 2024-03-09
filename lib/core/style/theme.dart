import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ip_checker/core/style/app_color.dart';

/// The `AppTheme` class provides predefined themes
class AppTheme {
  AppTheme._();

  /// lightTheme for light mode
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    primarySwatch: AppColor.primarySwatch,
    fontFamily: 'Rubik',
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontVariations: [FontVariation('wght', 700)],
        color: AppColor.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontVariations: [FontVariation('wght', 700)],
        color: AppColor.veryDarkGray,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontVariations: [FontVariation('wght', 500)],
        color: AppColor.veryDarkGray,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontVariations: [FontVariation('wght', 400)],
        color: AppColor.grey,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.primary,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColor.white,
      ),
      iconTheme: IconThemeData(color: AppColor.white),
    ),
    scaffoldBackgroundColor: AppColor.appBgColor,
    cardColor: Colors.white,
    shadowColor: AppColor.shadowColor,
    dividerColor: Colors.grey.shade400,
    iconTheme: const IconThemeData(color: AppColor.darker),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.bottomBarColor,
    ),
  );

  /// darkTheme for dark mode
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.primary,
    primarySwatch: AppColor.primarySwatch,
    fontFamily: 'Rubik',
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontVariations: [FontVariation('wght', 700)],
        color: AppColor.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontVariations: [FontVariation('wght', 700)],
        color: AppColor.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontVariations: [FontVariation('wght', 500)],
        color: AppColor.white,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontVariations: [FontVariation('wght', 400)],
        color: AppColor.grey,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1e1e1e),
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.white),
      shadowColor: Colors.grey,
    ),
    scaffoldBackgroundColor: const Color(0xFF1e1e1e),
    shadowColor: Colors.grey,
    cardColor: const Color(0xFF333333),
    dividerColor: Colors.white30,
    iconTheme: const IconThemeData(color: Colors.white),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF333333),
    ),
  );
}
