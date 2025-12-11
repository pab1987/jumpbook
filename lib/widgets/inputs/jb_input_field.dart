import 'package:flutter/material.dart';
import 'package:jumpbook/theme/app_colors.dart';

class JBInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final IconData? icon;
  final bool readOnly;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final TextInputType keyboard;
  final String? Function(String?)? validator;
  final double height;
  final double? width;
  final Color? hintColor;
  final Color? labelColor;
  final Color? textColor;

  const JBInputField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.icon,
    this.readOnly = false,
    this.onTap,
    this.keyboard = TextInputType.text,
    this.validator,
    this.height = 48, 
    this.width, 
    this.hintColor, 
    this.labelColor,
    this.textColor, 
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboard,
        validator: validator,
        style: TextStyle(
          color: textColor ?? AppColors.focusText,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: AppColors.backgroundTextField,
          
          labelStyle: TextStyle(
            color: labelColor ?? AppColors.focusText,
            fontSize: 14,
          ),
          hintStyle: TextStyle(
            color: hintColor ?? AppColors.focusText,
            fontSize: 14,
          ),
          prefixIcon: icon != null
              ? Icon(icon, color: AppColors.focusText)
              : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
