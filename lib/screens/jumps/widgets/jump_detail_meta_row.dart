import 'package:flutter/material.dart';
import 'package:jumpbook/models/jump_model.dart';
import 'package:jumpbook/theme/app_colors.dart';

class JumpDetailMetaRow extends StatelessWidget {
  final Jump jump;

  const JumpDetailMetaRow({super.key, required this.jump});

  Widget _box(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF7DD3FC),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _box('Aircraft', jump.aircraft),
        const SizedBox(width: 12),
        _box('Dropzone', jump.dropzone),
      ],
    );
  }
}
