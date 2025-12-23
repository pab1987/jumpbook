import 'package:flutter/material.dart';
import 'package:jumpbook/models/jump_model.dart';
import 'package:jumpbook/theme/app_colors.dart';

class JumpDetailObservations extends StatelessWidget {
  final Jump jump;

  const JumpDetailObservations({super.key, required this.jump});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Observations', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Text(jump.observations, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
