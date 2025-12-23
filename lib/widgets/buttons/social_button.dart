import 'package:flutter/material.dart';
import 'package:jumpbook/theme/app_colors.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final String assetPath; // El ícono (Apple o Google)
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.text,
    required this.assetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 150,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.textPrimary, width: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetPath, height: 20),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
