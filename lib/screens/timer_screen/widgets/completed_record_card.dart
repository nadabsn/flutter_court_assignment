import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';

class CompletedRecordCard extends StatelessWidget {
  final String dayName;
  final String date;
  final String startTime;
  final String duration;

  const CompletedRecordCard({
    super.key,
    required this.dayName,
    required this.date,
    required this.startTime,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 16),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayName,
                  style: AppTextStyles.muted.copyWith(fontSize: 12.w),
                ),
                Text(
                  date,
                  style: AppTextStyles.headline?.copyWith(fontSize: 16.w),
                ),
                Text(
                  'Start Time $startTime',
                  style: AppTextStyles.muted.copyWith(fontSize: 12.w),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(duration, style: AppTextStyles.buttonLabel),
          ),
        ],
      ),
    );
  }
}
