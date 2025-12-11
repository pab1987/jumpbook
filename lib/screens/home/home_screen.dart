import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:jumpbook/screens/home/widgets/jump_summary_card.dart';
import 'package:jumpbook/theme/app_colors.dart';
import 'package:jumpbook/widgets/buttons/custom_text_buttom.dart';
import 'package:flutter/material.dart';
import 'package:jumpbook/models/home_stats.dart';
import 'package:jumpbook/screens/home/widgets/home_main_stats.dart';
import 'package:jumpbook/screens/home/widgets/info_cards_row.dart';
import 'package:jumpbook/screens/home/widgets/jumpbook_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos temporales hasta que lleguen desde Firebase
    final stats = HomeStats(
      canopyHours: 5.8,
      freeflyHours: 1.6,
      currentJumps: 70,
      targetJumps: 100,
      lastJumpDate: '2-11-25',
      jpm: 5.2,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const JumpbookAppBar(
        icon: Icons.menu,
        title: 'Jumpbook',
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔷 Grupo superior (NO scrollea)
            HomeMainStats(stats: stats),
            const SizedBox(height: 20),

            const InfoCardsRow(),
            const SizedBox(height: 20),

            Text(
              "Recent jumps",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            // 🔥 SOLO ESTO SCROLLEA
            Expanded(
              child: ListView(
                children: [
                  JumpSummaryCard(
                    date: "15/10/25",
                    type: "Fun jump",
                    exitAltitude: "12.000 ft",
                    observations:
                        "Salida estable. Con un poco de inestabilidad al abrir el paracaídas. Apertura a 4.500 ft. Aterrizaje suave.",
                  ),
                  const SizedBox(height: 12),

                  JumpSummaryCard(
                    date: "14/10/25",
                    type: "Check dive",
                    exitAltitude: "10.000 ft",
                    observations:
                        "Se realizaron los ejercicios correctamente...",
                  ),
                  const SizedBox(height: 12),

                  JumpSummaryCard(
                    date: "13/10/25",
                    type: "Fun jump",
                    exitAltitude: "11.500 ft",
                    observations: "Salida en delta, un poco inestable...",
                  ),
                  const SizedBox(height: 20),

                  CustomTextButton(
                    text: 'Log out',
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ],
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
        ) ,
        child: IconButton(
          icon: const Icon(Icons.add, color: AppColors.addButton, size: 40),
          onPressed: () {
            context.go('/add_jump');
          },
        )
        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }
}
