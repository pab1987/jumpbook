import 'package:flutter/material.dart';
import 'package:jumpbook/theme/app_colors.dart';

class JumpbookCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsets? padding;
  final Color? color;
  final Color? accentColor;

  const JumpbookCard({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.padding, // <- ahora es opcional
    this.color,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final content = accentColor == null
        ? child
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 5,
                height: 110,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.only(right: 12),
              ),
              //Expanded(child: child),
              Flexible(
                fit:
                    FlexFit.loose, // permite que el child use su tamaño natural
                child: child,
              ),
            ],
          );

    return Container(
      decoration: BoxDecoration(
        color: color ?? AppColors.card,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.background,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: padding == null
          ? content
          : Padding(padding: padding!, child: content),
    );
  }
}
