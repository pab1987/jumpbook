import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jumpbook/theme/app_colors.dart';

class JBFieldRow extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final String? suffix;
  final bool enabled;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  const JBFieldRow({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.suffix,
    this.enabled = true,
    this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // LABEL
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // INPUT BOX
          SizedBox(
            width: 180,
            height: 40,
            child: TextField(
              keyboardType: keyboardType,
              controller: controller,
              enabled: enabled,
              onChanged: onChanged,
              ///textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.backgroundTextField,
                isDense: true,
                hint: Text(hintText ?? '', style: TextStyle(
                  color: AppColors.placeholder,
                  fontSize: 15,
                ),),
                contentPadding:
                    const EdgeInsets.symmetric( vertical: 10, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixText: suffix,
                suffixStyle: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              style: TextStyle(
                color: enabled
                    ? AppColors.textPrimary
                    : AppColors.placeholder,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
