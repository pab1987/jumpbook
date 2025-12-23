import 'package:flutter/material.dart';
import 'package:jumpbook/models/jump_model.dart';
import 'package:jumpbook/theme/app_colors.dart';
import 'package:jumpbook/screens/home/widgets/jumpbook_app_bar.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_detail_header.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_detail_main_stats.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_detail_meta_row.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_detail_secondary_stats.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_detail_observations.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_detail_actions.dart';

class JumpDetailScreen extends StatelessWidget {
  final Jump jump;
  final int? jumpNumber;

  const JumpDetailScreen({super.key, required this.jump, this.jumpNumber});

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: JumpbookAppBar(
        icon: Icons.arrow_back_ios_new_rounded,
        title: 'Jump Detail $jumpNumber',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //JumpDetailHeader(jump: jump, formatDate: formatDate),
            const SizedBox(height: 16),
            JumpDetailMainStats(jump: jump),
            const SizedBox(height: 16),
            JumpDetailMetaRow(jump: jump),
            const SizedBox(height: 16),
            JumpDetailSecondaryStats(jump: jump),
            const SizedBox(height: 16),
            JumpDetailObservations(jump: jump),
            const SizedBox(height: 24),
            const JumpDetailActions(),
          ],
        ),
      ),
    );
  }
}
