import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jumpbook/providers/jump_providers.dart';
import 'package:jumpbook/screens/home/widgets/jump_summary_card.dart';
import 'package:jumpbook/screens/home/widgets/jumpbook_app_bar.dart';
import 'package:jumpbook/theme/app_colors.dart';

class AllJumpsScreen extends ConsumerWidget {
  const AllJumpsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jumpsAsync = ref.watch(jumpsStreamProvider);

    String formatDate(DateTime date) {
      return '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const JumpbookAppBar(
        icon: Icons.arrow_back_ios_new_rounded,
        title: 'Jumpbook',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: jumpsAsync.when(
          data: (jumps) {
            if (jumps.isEmpty) {
              return const Center(child: Text('No hay saltos registrados'));
            }
            return ListView.separated(
              itemCount: jumps.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final jump = jumps[index];
                final jumpNumber = jumps.length - index;
                return GestureDetector(
                  onTap: () {
                    context.push(
                      '/jump_detail',
                      extra: {
                        'jump': jump,
                        'jumpNumber': jumpNumber,
                      },
                    );
                  },
                  child: JumpSummaryCard(
                    date: formatDate(jump.date),
                    type: jump.jumpType,
                    exitAltitude: jump.exitAltitude,
                    observations: jump.observations,
                    //jumpNumber: jumpNumber,
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Error: $err')),
        ),
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
          boxShadow: [
            BoxShadow(
              color: AppColors.background,
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.add, color: AppColors.addButton, size: 40),
          onPressed: () => context.push('/add_jump'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
