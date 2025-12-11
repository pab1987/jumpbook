import 'package:flutter/material.dart';

class JBFieldGroup extends StatelessWidget {
  final List<Widget> children;

  const JBFieldGroup({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...children,
        ],
      ),
    );
  }
}
