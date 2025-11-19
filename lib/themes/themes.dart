import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'styles_text.dart';

class AppTheme {
  static ThemeData get lightThem {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: AppFont.appFont,
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.white,
        selectionColor: AppColors.primary1.withOpacity(0.5),
        selectionHandleColor: AppColors.primary1.withOpacity(0.5),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent, tabBarTheme: TabBarThemeData(indicatorColor: AppColors.white), colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.white,
        onSurface: Colors.black,
      ).copyWith(background: AppColors.white),
    );
  }
}
