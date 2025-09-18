import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_colors.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';

class TimeSelectionWidget extends StatelessWidget {
  final List<TimeOfDay> availableTimeSlots;
  final TimeOfDay? selectedStartTime;
  final Function(TimeOfDay) onTimeSelected;

  const TimeSelectionWidget({
    super.key,
    required this.availableTimeSlots,
    required this.selectedStartTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Times',
          style: AppTextStyles.subtitle.copyWith(
            fontSize: 18.w,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        if (availableTimeSlots.isEmpty) ...[
          _buildEmptyState(),
        ] else ...[
          _buildTimeGrid(context),
        ],
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.schedule, size: 48.w, color: AppColors.mutedWhite),
            SizedBox(height: 8.h),
            Text(
              'No available times for this date',
              style: AppTextStyles.muted,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 2.5,
      ),
      itemCount: availableTimeSlots.length,
      itemBuilder: (context, index) {
        final timeSlot = availableTimeSlots[index];
        final isSelected = selectedStartTime == timeSlot;

        return TimeSlotCard(
          timeSlot: timeSlot,
          isSelected: isSelected,
          onTap: () => onTimeSelected(timeSlot),
        );
      },
    );
  }
}

class TimeSlotCard extends StatelessWidget {
  final TimeOfDay timeSlot;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotCard({
    super.key,
    required this.timeSlot,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.w),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : AppColors.card,
          borderRadius: BorderRadius.circular(8.w),
          border: Border.all(
            color: isSelected ? AppColors.accent : Colors.transparent,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            timeSlot.format(context),
            style: AppTextStyles.buttonLabel.copyWith(
              color: isSelected ? AppColors.background : Colors.white,
              fontSize: 14.w,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
