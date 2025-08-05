import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.transparent,
  // Changed to transparent
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent, // Make AppBar transparent
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.white),
    titleTextStyle: AppTextStyles.headline,
  ),
  iconTheme: IconThemeData(color: AppColors.white),
  textTheme: TextTheme(
    headlineLarge: AppTextStyles.headline,
    titleMedium: AppTextStyles.subtitle,
    titleSmall: AppTextStyles.muted,
  ),
  colorScheme: const ColorScheme.dark().copyWith(
    primary: AppColors.accent,
    background: Colors.transparent, // Changed to transparent
    surface: AppColors.card,
  ),
  useMaterial3: false,
);
