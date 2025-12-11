import 'package:flutter/material.dart';
import 'package:jumpbook/theme/app_colors.dart';

class InfoCard extends StatelessWidget {
  final Widget? icon;
  final String? iconAsset;
  final double iconSize;

  final String mainText;
  final TextStyle? mainTextStyle;

  final List<String> subTexts;
  final TextStyle? subTextStyle;

  final double spacing;
  final EdgeInsetsGeometry? padding;
  final CrossAxisAlignment alignment;

  const InfoCard({
    super.key,
    this.icon,
    this.iconAsset,
    this.iconSize = 35,
    required this.mainText,
    this.mainTextStyle,
    this.subTexts = const [],
    this.subTextStyle,
    this.spacing = 2.0,
    this.padding,
    this.alignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          if (icon != null)
            SizedBox(
              height: iconSize,
              width: iconSize,
              child: icon!,
            )
          else if (iconAsset != null)
            Image.asset(
              iconAsset!,
              height: iconSize,
              width: iconSize,
            ),

          SizedBox(height: spacing),

          Text(
            mainText,
            style: mainTextStyle ??
                TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.focusText,
                ),
          ),

          ...subTexts.map(
            (text) => Padding(
              padding: EdgeInsets.only(top: spacing),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: subTextStyle ??
                    TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
