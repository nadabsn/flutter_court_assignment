import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_colors.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';

import '../../../../core/common/models/court.dart';

class BookingSummaryWidget extends StatelessWidget {
  final Court court;
  final DateTime selectedDate;
  final TimeOfDay startTime;
  final bool isLoading;
  final VoidCallback onBookPressed;

  const BookingSummaryWidget({
    super.key,
    required this.court,
    required this.selectedDate,
    required this.startTime,
    required this.isLoading,
    required this.onBookPressed,
  });

  @override
  Widget build(BuildContext context) {
    final int startMinutes = startTime.hour * 60 + startTime.minute;
    final int endMinutes = startMinutes + court.slotMinutes;
    final endTime = TimeOfDay(hour: endMinutes ~/ 60, minute: endMinutes % 60);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Column(
        children: [
          // Booking Summary
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Booking Summary',
                  style: AppTextStyles.subtitle.copyWith(
                    fontSize: 18.w,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16.h),
                _buildSummaryRow(
                  Icons.sports,
                  '${court.label} (${court.sport})',
                ),
                SizedBox(height: 8.h),
                _buildSummaryRow(
                  Icons.calendar_today,
                  DateFormat('MMM dd, yyyy').format(selectedDate),
                ),
                SizedBox(height: 8.h),
                _buildSummaryRow(
                  Icons.schedule,
                  '${startTime.format(context)} - ${endTime.format(context)}',
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.payment,
                            size: 16.w, color: AppColors.mutedWhite),
                        SizedBox(width: 8.w),
                        Text('Total:', style: AppTextStyles.muted),
                      ],
                    ),
                    Text(
                      '${court.price.toInt()} DT',
                      style: AppTextStyles.subtitle.copyWith(
                        fontSize: 20.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Book Button
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.w),
            child: ElevatedButton(
              onPressed: isLoading ? null : onBookPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.w),
                ),
              ),
              child: isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: const CircularProgressIndicator(
                        color: AppColors.background,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Book Court',
                      style: AppTextStyles.buttonLabel.copyWith(
                        color: AppColors.background,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.w, color: AppColors.mutedWhite),
        SizedBox(width: 8.w),
        Text(text, style: AppTextStyles.muted),
      ],
    );
  }
}
