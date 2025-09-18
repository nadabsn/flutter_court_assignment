import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';

class FacilityHeaderWidget extends StatelessWidget {
  final String facilityName;
  final VoidCallback onBackPressed;

  const FacilityHeaderWidget({
    super.key,
    required this.facilityName,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          IconButton(
            onPressed: onBackPressed,
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.w),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              facilityName,
              style: AppTextStyles.headline?.copyWith(fontSize: 24.w),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
