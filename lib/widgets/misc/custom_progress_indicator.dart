import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CustomSleekProgressIndicator extends StatelessWidget {

  final int currentJumps;
  final int targetJumps;

  /// PERSONALIZACIÓN GENERAL
  final double minValue;
  final double maxValue;
  final double startAngle;
  final double angleRange;
  final double strokeThickness;

  /// COLORES
  final Color? progressColor;
  final Color? trackColor;
  final Color? textColor;
  final Color? bottomTextColor;

  /// TEXTOS
  final double mainFontSize;
  final double bottomFontSize;
  final FontWeight mainFontWeight;
  final FontWeight bottomFontWeight;
  final String? bottomLabelText;
  final String? topLabelText;

  /// ANIMACIONES
  final Duration animationDuration;

  const CustomSleekProgressIndicator({
    super.key,

    required this.currentJumps,
    required this.targetJumps,

    // Defaults
    this.minValue = 0,
    this.maxValue = 100,
    this.startAngle = 270,
    this.angleRange = 360,
    this.strokeThickness = 12.0,

    // Colores
    this.progressColor,
    this.trackColor,
    this.textColor,
    this.bottomTextColor,

    // Textos
    this.mainFontSize = 24,
    this.bottomFontSize = 14,
    this.mainFontWeight = FontWeight.w600,
    this.bottomFontWeight = FontWeight.w400,
    this.bottomLabelText,
    this.topLabelText,

    // Animación
    this.animationDuration = const Duration(milliseconds: 800),
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = (currentJumps / targetJumps) * 100;

    return SleekCircularSlider(
      min: minValue,
      max: maxValue,
      initialValue: percentage.clamp(0, 100),
      appearance: CircularSliderAppearance(
        startAngle: startAngle,
        angleRange: angleRange,
        animationEnabled: true,
        spinnerMode: false,
        customWidths: CustomSliderWidths(
          progressBarWidth: strokeThickness,
          trackWidth: strokeThickness / 1.8,
        ),
        customColors: CustomSliderColors(
          //progressBarColor: progressColor ?? Colors.blueAccent,
          trackColor: trackColor ?? Colors.grey.shade300,
          //dotColor: Colors.transparent,
        ),
        infoProperties: InfoProperties(
          topLabelText: topLabelText,
          bottomLabelText: bottomLabelText ?? 'Jumps',
          mainLabelStyle: TextStyle(
            color: textColor ?? Colors.black,
            fontSize: mainFontSize,
            fontWeight: mainFontWeight,
          ),
          bottomLabelStyle: TextStyle(
            color: bottomTextColor ?? Colors.grey,
            fontSize: bottomFontSize,
            fontWeight: bottomFontWeight,
          ),
          modifier: (double value) {
            return "$currentJumps/$targetJumps";
          },
        ),
      ),
    );
  }
}
