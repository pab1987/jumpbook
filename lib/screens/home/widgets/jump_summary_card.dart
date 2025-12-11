import 'package:flutter/material.dart';
import 'package:jumpbook/theme/app_colors.dart';
import 'package:jumpbook/widgets/layout/custom_container.dart';

class JumpSummaryCard extends StatelessWidget {
  final String date;
  final String type;
  final String exitAltitude;
  final String observations;
  final Color accent;

  const JumpSummaryCard({
    super.key,
    required this.date,
    required this.type,
    required this.exitAltitude,
    required this.observations,
    this.accent = const Color(0xFF5CC97B),
  });

  @override
  Widget build(BuildContext context) {
    return JumpbookCard(
      accentColor: accent,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Date:  $date",
              style: TextStyle(fontSize: 16, color: AppColors.textPrimary, fontWeight: FontWeight.w600)),

          const SizedBox(height: 6),

          Text("Jump type:  $type",
              style: TextStyle(color: AppColors.textSecondary)),

          Text("Exit altitude:  $exitAltitude",
              style: TextStyle(color: AppColors.textSecondary)),

          const SizedBox(height: 6),

          Text("Observations: $observations",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
