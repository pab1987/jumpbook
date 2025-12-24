import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import 'package:jumpbook/providers/jump_providers.dart';
import 'package:jumpbook/screens/home/widgets/jump_summary_card.dart';
import 'package:jumpbook/screens/home/widgets/home_main_stats.dart';
import 'package:jumpbook/screens/home/widgets/info_cards_row.dart';
import 'package:jumpbook/screens/home/widgets/jumpbook_app_bar.dart';
import 'package:jumpbook/theme/app_colors.dart';
import 'package:jumpbook/widgets/buttons/custom_button.dart';
import 'package:jumpbook/widgets/buttons/custom_text_buttom.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jumpsAsync = ref.watch(jumpsStreamProvider);



    // Obtenemos los stats ya procesados desde el provider
    final stats = ref.watch(homeStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const JumpbookAppBar(icon: Icons.menu, title: 'Jumpbook'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeMainStats(stats: stats),
            const SizedBox(height: 10),
            const InfoCardsRow(), // TODO: implementar InfoCardsRow de forma dinamica
            const SizedBox(height: 10),

            Text(
              "Recent jumps",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            /// 🔥 LISTA DE ÚLTIMOS 3 SALTOS
            Expanded(
              child: jumpsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('Error: $err')),
                data: (jumps) {
                  if (jumps.isEmpty) {
                    return const Center(
                      child: Text('No hay saltos registrados'),
                    );
                  }

                  final recentJumps = jumps.take(3).toList();

                  return ListView(
                    children: [
                      ...recentJumps.map(
                        (jump) {
                          final jumpNumber = jumps.length - jumps.indexOf(jump);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GestureDetector(
                              onTap: () => context.push(
                                '/jump_detail',
                                extra: {
                                  'jump': jump,
                                  'jumpNumber': jumpNumber,
                                },
                              ),
                              child: JumpSummaryCard(
                                date: formatDate(jump.date),
                                type: jump.jumpType,
                                exitAltitude: '${jump.exitAltitude} ft',
                                observations: jump.observations,
                              ),
                            ),
                          );
                        },
                      ),

                      /// 🔹 BOTÓN VER TODOS
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 24),
                        child: CustomButton(
                          text: 'View All Jumps',
                          onPressed: () => context.push('/all_jumps'),
                          backgroundColor: AppColors.addButton,
                          borderRadius: 12,
                          fontSize: 16,
                          height: 40,
                          fontWeight: FontWeight.w600,
                          padding: EdgeInsets.zero,
                        ),
                      ),

                      /// 🔹 LOGOUT
                      CustomTextButton(
                        text: 'Log out',
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
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
