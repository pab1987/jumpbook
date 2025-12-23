import 'package:flutter/material.dart';
import 'package:jumpbook/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;

  // --- Propiedades de Estilo y Geometría ---
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets? padding;
  final double borderRadius;

  // --- Propiedades Añadidas para Alto y Ancho ---
  final double? height; // Alto opcional
  final double? width; // Ancho opcional
  // ----------------------------------------------

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
    this.backgroundColor,

    this.textColor = Colors.white,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
    this.padding,
    this.borderRadius = 12.0,

    // Inicialización de las nuevas propiedades
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final Color indicatorColor = textColor ?? Colors.white;

    // 1. Envolvemos el ElevatedButton en un SizedBox para controlar height/width
    return SizedBox(
      height: height,
      width: width,

      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          // Ajustamos el padding para que no interfiera si height está establecido,
          // pero lo mantenemos como fallback o si height es nulo.
          padding:
              padding ??
              const EdgeInsets.symmetric(vertical: 15, horizontal: 30),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),

          backgroundColor: backgroundColor ?? AppColors.addButton,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: loading
              ? SizedBox(
                  key: const ValueKey("loading"),
                  width: fontSize + 8,
                  height: fontSize + 8,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: indicatorColor,
                  ),
                )
              : Text(
                  text,
                  key: const ValueKey("text"),
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor,
                  ),
                ),
        ),
      ),
    );
  }
}
