import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jumpbook/theme/app_colors.dart';
import 'package:jumpbook/widgets/common/custom_text_buttom.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jumpbook Home"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Home Screen"),
            const SizedBox(height: 20),

            CustomTextButton(
              text: 'Logout',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
