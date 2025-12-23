import 'package:flutter/material.dart';
import 'package:jumpbook/models/jump_model.dart';
import 'package:jumpbook/theme/app_colors.dart';

/* 
class JumpDetailSecondaryStats extends StatelessWidget {
  final Jump jump;

  const JumpDetailSecondaryStats({super.key, required this.jump});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(jump.jumpType),
          Text(jump.flightMode),
          Text('${jump.deployment} ft'),
          Text('${jump.canopySize}'),
        ],
      ),
    );
  }
}
 */
class JumpDetailSecondaryStats extends StatelessWidget {
  final Jump jump;

  const JumpDetailSecondaryStats({super.key, required this.jump});

  Widget _item(String label, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white70,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),

        // 👇 CONTENEDOR DE ALTURA FIJA
        SizedBox(
          height: 20,
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String capitalize(String text) {
      if (text.isEmpty) return text;
      return text[0].toUpperCase() + text.substring(1);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(child: _item('Jump Type', capitalize(jump.jumpType))),
          Expanded(child: _item('Flight Mode', capitalize( jump.flightMode))),
          Expanded(child: _item('Deployment', '${jump.deployment} ft')),
          Expanded(child: _item('Canopy Size', '${jump.canopySize}')),
        ],
      ),
    );
  }
}
