import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.background,
    elevation: 0,
    iconTheme:  IconThemeData(color: AppColors.white),
    titleTextStyle: AppTextStyles.headline as TextStyle?,
  ),
  iconTheme:  IconThemeData(color: AppColors.white),
  textTheme: TextTheme(
    headlineLarge: AppTextStyles.headline as TextStyle?,
    titleMedium: AppTextStyles.subtitle as TextStyle?,
    titleSmall: AppTextStyles.muted as TextStyle?,
  ),
  colorScheme: const ColorScheme.dark().copyWith(
    primary: AppColors.accent,
    background: AppColors.background,
    surface: AppColors.card,
  ),
  useMaterial3: false,
);