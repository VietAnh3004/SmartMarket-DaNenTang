import 'package:fe/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPalette.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.backgroundColor,
    ),
    // chipTheme: const ChipThemeData(
    //   color: MaterialStatePropertyAll(
    //     AppPalette.backgroundColor,
    //   ),
    //   side: BorderSide.none,
    // ),
    inputDecorationTheme: InputDecorationTheme(
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPalette.primaryColor),
      errorBorder: _border(AppPalette.errorColor),
    ),
  );
}