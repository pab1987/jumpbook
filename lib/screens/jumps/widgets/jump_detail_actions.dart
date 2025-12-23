import 'package:flutter/material.dart';

class JumpDetailActions extends StatelessWidget {
  const JumpDetailActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Edit Jump'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {},
            child: const Text('Delete Jump'),
          ),
        ),
      ],
    );
  }
}
