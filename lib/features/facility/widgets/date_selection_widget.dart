import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_colors.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';

class DateSelectionWidget extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onDateTap;

  const DateSelectionWidget({
    super.key,
    required this.selectedDate,
    required this.onDateTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Date',
          style: AppTextStyles.subtitle.copyWith(
            fontSize: 18.w,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12.w),
            onTap: onDateTap,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 20.w, color: AppColors.accent),
                  SizedBox(width: 12.w),
                  Text(
                    selectedDate == null
                        ? 'Choose a date'
                        : DateFormat('EEEE, MMM dd, yyyy')
                            .format(selectedDate!),
                    style: AppTextStyles.subtitle.copyWith(fontSize: 16.w),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward_ios,
                      size: 16.w, color: AppColors.mutedWhite),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
