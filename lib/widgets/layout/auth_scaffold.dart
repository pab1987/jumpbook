import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Widget? header;

  const AuthScaffold({
    super.key,
    required this.title,
    required this.children,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (header != null) ...[header!, const SizedBox(height: 15)],
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
