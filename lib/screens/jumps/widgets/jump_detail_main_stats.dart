import 'package:flutter/material.dart';
import 'package:jumpbook/models/jump_model.dart';
import 'package:jumpbook/theme/app_colors.dart';

class JumpDetailMainStats extends StatelessWidget {
  final Jump jump;

  const JumpDetailMainStats({super.key, required this.jump});

  Widget _stat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF7DD3FC),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// COLUMNA IZQUIERDA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stat('EXIT ALTITUDE', '${jump.exitAltitude} ft'),
                const SizedBox(height: 16),
                _stat('SPEED MAX', '${jump.speedMax} km/h'),
              ],
            ),
          ),

          /// COLUMNA DERECHA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stat('FREEFALL TIME', '${jump.freefall} s'),
                const SizedBox(height: 16),
                _stat(
                  'CANOPY TIME',
                  jump.canopyTime.isEmpty ? '—' : '${jump.canopyTime} s',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
