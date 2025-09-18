import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const EmptyState({
    super.key,
    this.title = 'No facilities found',
    this.subtitle = 'Try adjusting your search or filters',
    this.icon = Icons.sports_tennis,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64.w,
            color: AppColors.mutedWhite,
          ),
          SizedBox(height: 16.h),
          Text(title, style: AppTextStyles.subtitle),
          SizedBox(height: 8.h),
          Text(subtitle, style: AppTextStyles.muted),
        ],
      ),
    );
  }
}
