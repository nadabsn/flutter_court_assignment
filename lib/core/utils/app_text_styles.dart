import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';

import 'app_colors.dart';

class AppTextStyles {
  // Convert all static properties to getters
  static TextStyle get headline => TextStyle(
        fontSize: 32.w,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      );

  static TextStyle get subtitle => TextStyle(
        fontSize: 16.w,
        color: AppColors.white,
      );

  static TextStyle get muted => TextStyle(
        fontSize: 16.w,
        color: AppColors.mutedWhite,
      );

  static TextStyle get smallText => TextStyle(
        fontSize: 12.w,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get buttonLabel => TextStyle(
        fontSize: 14.w,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );

  static TextStyle get tabBarText => TextStyle(
        fontSize: 20.w,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      );

  static TextStyle get timerTitle => TextStyle(
        fontSize: 24.w,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      );

  static TextStyle get timerElapsedTime => TextStyle(
        color: Colors.white,
        fontSize: 48.w,
        fontWeight: FontWeight.w300,
        letterSpacing: -1,
      );

  static TextStyle get timerProjectText => TextStyle(
        color: Colors.white.withOpacity(0.8),
        fontSize: 14.w,
      );

  static TextStyle get errorText => TextStyle(
        color: Colors.redAccent,
        fontSize: 12.w,
      );
}
