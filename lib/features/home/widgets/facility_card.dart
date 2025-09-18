import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_assignment_flutter/core/common/models/facility.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_text_styles.dart';

class FacilityCard extends StatelessWidget {
  final Facility facility;

  const FacilityCard({super.key, required this.facility});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/facility', extra: facility),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Facility Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                height: 160.h,
                width: double.infinity,
                color: AppColors.mutedWhite.withOpacity(0.1),
                child: const Icon(
                  Icons.image,
                  size: 48,
                  color: AppColors.mutedWhite,
                ),
              ),
            ),
            // Facility Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    facility.name,
                    style: AppTextStyles.subtitle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: AppColors.mutedWhite),
                      SizedBox(width: 4.w),
                      Text(facility.city,
                          style: AppTextStyles.muted.copyWith(fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Sports Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: facility.sports
                        .map((sport) => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                sport.toUpperCase(),
                                style: AppTextStyles.smallText.copyWith(
                                  color: AppColors.accent,
                                  fontSize: 10,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 8.h),

                  // Courts Count and Price Range
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${facility.courts.length} courts available',
                        style: AppTextStyles.muted.copyWith(fontSize: 12),
                      ),
                      Text(
                        'From ${facility.courts.map((c) => c.price).reduce((a, b) => a < b ? a : b).toInt()} DT/hour',
                        style: AppTextStyles.subtitle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
