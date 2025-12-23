import 'package:flutter/material.dart';
import 'package:jumpbook/models/jump_model.dart';

class JumpDetailHeader extends StatelessWidget {
  final Jump jump;
  final String Function(DateTime) formatDate;

  const JumpDetailHeader({
    super.key,
    required this.jump,
    required this.formatDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Jump #${jump.id.substring(0, 4)}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          formatDate(jump.date),
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    );
  }
}
