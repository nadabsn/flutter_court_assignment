import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_colors.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';
import 'package:test_assignment_flutter/features/facility/models/facility.dart';

class FacilityInfoWidget extends StatelessWidget {
  final Facility facility;

  const FacilityInfoWidget({
    super.key,
    required this.facility,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Facility Image Placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(12.w),
            child: Container(
              height: 200.h,
              width: double.infinity,
              color: AppColors.mutedWhite.withOpacity(0.1),
              child: Icon(
                Icons.image,
                size: 64.w,
                color: AppColors.mutedWhite,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              Icon(Icons.location_on, size: 18.w, color: AppColors.mutedWhite),
              SizedBox(width: 4.w),
              Text(
                facility.city,
                style: AppTextStyles.muted.copyWith(fontSize: 16.w),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Sports Tags
          Wrap(
            spacing: 8.w,
            runSpacing: 4.h,
            children: facility.sports
                .map((sport) => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                      child: Text(
                        sport.toUpperCase(),
                        style: AppTextStyles.smallText.copyWith(
                          color: AppColors.accent,
                          fontSize: 12.w,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
