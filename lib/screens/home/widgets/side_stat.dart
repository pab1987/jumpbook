import 'package:flutter/material.dart';
import 'package:jumpbook/theme/app_colors.dart';

class SideStat extends StatelessWidget {
  final String icon;
  final String value;
  final String label;

  const SideStat({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95,
      height: 90,
      child: Column(
        children: [
          Image.asset(icon, height: 35, width: 35),
          Text(
            value,
            style: TextStyle(
              color: AppColors.focusText,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
