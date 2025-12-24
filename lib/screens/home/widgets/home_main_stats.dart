import 'package:flutter/material.dart';
import 'package:jumpbook/models/home_stats.dart';
import 'package:jumpbook/theme/app_colors.dart';
import 'package:jumpbook/widgets/layout/custom_container.dart';
import 'package:jumpbook/widgets/misc/custom_progress_indicator.dart';
import 'side_stat.dart';

class HomeMainStats extends StatelessWidget {
  final HomeStats stats;

  const HomeMainStats({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return JumpbookCard(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      color: AppColors.card,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SideStat(
                icon: 'assets/icons/canopy.png',
                value: stats.canopyHours.toString(),
                label: 'Hours canopy',
              ),
              const SizedBox(height: 10),
              SideStat(
                icon: 'assets/icons/exit_freefall.png',
                value: stats.freeFallHours.toString(),
                label: 'Hours freefly',
              ),
            ],
          ),

          Stack(
            children: [
              const SizedBox(width: 150, height: 150),
              CustomSleekProgressIndicator(
                currentJumps: stats.currentJumps,
                targetJumps: stats.targetJumps,
                textColor: AppColors.textPrimary,
                bottomTextColor: AppColors.textSecondary,
              ),
            ],
          ),

          Column(
            children: [
              SideStat(
                icon: 'assets/icons/calendar.png',
                value: stats.lastJumpDate,
                label: 'Last jump',
              ),
              const SizedBox(height: 10),
              SideStat(
                icon: 'assets/icons/plane.png',
                value: stats.jpm.toString(),
                label: 'JPM',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
