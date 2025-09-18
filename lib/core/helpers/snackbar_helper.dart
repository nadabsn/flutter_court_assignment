import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';

enum SnackbarType { success, error }

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.success,
  }) {
    final color = type == SnackbarType.success ? Colors.green : Colors.red;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                type == SnackbarType.success ? Icons.check_circle : Icons.error,
                color: Colors.white,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
