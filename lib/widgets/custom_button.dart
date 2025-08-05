// gradient_button.dart
import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';

class TransparentWhiteButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TransparentWhiteButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(child: Text(text, style: AppTextStyles.buttonLabel)),
      ),
    );
  }
}
