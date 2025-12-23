import 'package:flutter/material.dart';
import 'package:jumpbook/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final IconData? icon;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscure = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: AppColors.textPrimary),
      controller: controller,
      obscureText: obscure,
      cursorColor: AppColors.textPrimary,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        hintText: label,
        hintStyle: TextStyle(color: AppColors.placeholder),
        prefixIcon: icon != null
            ? Icon(icon, color: AppColors.placeholder)
            : null,
      ),
    );
  }
}
