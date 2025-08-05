import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle? headline = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle subtitle = TextStyle(fontSize: 16.w, color: AppColors.white);

  static TextStyle muted = TextStyle(
    fontSize: 16.w,
    color: AppColors.mutedWhite,
  );

  static TextStyle smallText = TextStyle(
    fontSize: 12.w,
    fontWeight: FontWeight.w600,
  );

  static TextStyle buttonLabel = TextStyle(
    fontSize: 14.w,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle tabBarText = TextStyle(
    fontSize: 20.w,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static TextStyle timerTitle = TextStyle(
    fontSize: 24.w,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static TextStyle timerElapsedTime = TextStyle(
    color: Colors.white,
    fontSize: 48.w,
    fontWeight: FontWeight.w300,
    letterSpacing: -1,
  );
  static TextStyle timerProjectText = TextStyle(
    color: Colors.white.withOpacity(0.8),
    fontSize: 14.w,
  );
  static TextStyle errorText = TextStyle(
    color: Colors.redAccent,
    fontSize: 12.w,
  );
}
