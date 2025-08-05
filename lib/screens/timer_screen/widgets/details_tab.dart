import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';

class DetailsTab extends StatelessWidget {
  const DetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Details Tab Content',
        style: AppTextStyles.headline?.copyWith(fontSize: 18.w),
      ),
    );
  }
}
