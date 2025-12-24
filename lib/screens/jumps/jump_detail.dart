import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jumpbook/models/jump_model.dart';
import 'package:jumpbook/theme/app_colors.dart';
import 'package:jumpbook/screens/home/widgets/jumpbook_app_bar.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_detail_main_stats.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_detail_meta_row.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_detail_secondary_stats.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_detail_observations.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_detail_actions.dart';
import 'package:jumpbook/providers/jump_providers.dart';

class JumpDetailScreen extends ConsumerWidget {
  final Jump jump;
  final int? jumpNumber;

  const JumpDetailScreen({super.key, required this.jump, this.jumpNumber});

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jumpsAsync = ref.watch(jumpsStreamProvider);

    // Determinar el Jump actual a mostrar: preferir el del stream si está disponible
    final currentJump = jumpsAsync.when(
      data: (jumps) =>
          jumps.firstWhere((j) => j.id == jump.id, orElse: () => jump),
      loading: () => jump,
      error: (_, __) => jump,
    );

    // Recalcular número de salto dinámicamente si el stream está disponible
    final currentJumpNumber = jumpsAsync.when(
      data: (jumps) {
        final idx = jumps.indexWhere((j) => j.id == jump.id);
        if (idx == -1) return jumpNumber;
        return jumps.length - idx;
      },
      loading: () => jumpNumber,
      error: (_, __) => jumpNumber,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: JumpbookAppBar(
        icon: Icons.arrow_back_ios_new_rounded,
        title: 'Jump Detail ${currentJumpNumber ?? ''}',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //JumpDetailHeader(jump: currentJump, formatDate: formatDate),
            const SizedBox(height: 16),
            JumpDetailMainStats(jump: currentJump),
            const SizedBox(height: 16),
            JumpDetailMetaRow(jump: currentJump),
            const SizedBox(height: 16),
            JumpDetailSecondaryStats(jump: currentJump),
            const SizedBox(height: 16),
            JumpDetailObservations(jump: currentJump),
            const SizedBox(height: 24),
            JumpDetailActions(jumpId: currentJump.id),
          ],
        ),
      ),
    );
  }
}
