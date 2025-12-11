import 'package:flutter/material.dart';
import 'package:jumpbook/theme/app_colors.dart';

class CustomTextButton extends StatelessWidget {

  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;


  const CustomTextButton({
    super.key, 
    required this.text, 
    this.onPressed, 
    this.color, 
    required this.fontSize, 
    required this.fontWeight
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color ?? AppColors.primary,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}