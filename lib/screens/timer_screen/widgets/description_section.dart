import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';

class DescriptionSection extends StatelessWidget {
  final String description;
  final VoidCallback onEdit;
  final bool showReadMore;

  const DescriptionSection({
    super.key,
    required this.description,
    required this.onEdit,
    this.showReadMore = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Description',
              style: AppTextStyles.headline?.copyWith(fontSize: 16.w),
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
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: AppTextStyles.buttonLabel.copyWith(
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (showReadMore) ...[
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Read More',
                    style: AppTextStyles.muted.copyWith(
                      fontSize: 14.w,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
