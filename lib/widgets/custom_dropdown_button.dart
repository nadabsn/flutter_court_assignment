import 'package:flutter/material.dart';
import 'package:test_assignment_flutter/core/utils/app_colors.dart';

import '../core/utils/app_text_styles.dart';

class CustomDropdownButton extends StatefulWidget {
  final String hint;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownButton({
    super.key,
    required this.hint,
    required this.items,
    this.selectedValue,
    this.onChanged,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.2), // Lighter blue border
          width: 1.5,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.selectedValue,
          hint: Text(widget.hint, style: AppTextStyles.subtitle),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 24,
          ),
          dropdownColor: AppColors.background,
          style: AppTextStyles.subtitle,
          isExpanded: true,
          items:
              widget.items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: AppTextStyles.subtitle),
                );
              }).toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
