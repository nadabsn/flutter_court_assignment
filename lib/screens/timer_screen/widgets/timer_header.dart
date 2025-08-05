import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';
import 'package:test_assignment_flutter/models/timer_model.dart';

class TimerHeader extends StatelessWidget {
  final TimerModel? timer;
  final VoidCallback onBack;
  final VoidCallback onEdit;

  const TimerHeader({
    super.key,
    required this.timer,
    required this.onBack,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0.w),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: onBack,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              timer?.description ?? 'Timer Details',
              style: AppTextStyles.headline?.copyWith(fontSize: 18.w),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
