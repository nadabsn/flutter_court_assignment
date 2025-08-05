import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/utils/app_text_styles.dart';

import '../core/utils/app_strings.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        selectedLabelStyle: AppTextStyles.smallText,
        unselectedLabelStyle: AppTextStyles.smallText.copyWith(
          fontWeight: FontWeight.w400,
        ),
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.access_time),
            label: AppStrings.timeSheetsTitle,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.folder_outlined),
            label: 'Projects',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
