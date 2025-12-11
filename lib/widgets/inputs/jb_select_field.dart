import 'package:flutter/material.dart';
import 'package:jumpbook/theme/app_colors.dart';

class JBSelectFieldEnum<T extends Enum> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String Function(T item)? toLabel;
  final String? label;
  final String? hint;
  final Widget? icon;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final double height;
  final double? width;
  final Color? labelColor;

  const JBSelectFieldEnum({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.toLabel,
    this.label,
    this.hint,
    this.icon,
    this.validator,
    this.height = 48,
    this.width,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    //final error = validator?.call(value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height,
          width: width,
          child: DropdownButtonFormField<T>(
            //dropdownColor: AppColors.card,
            isExpanded: true,
            initialValue: value,
            onChanged: onChanged,
            // Quitamos el validator para que NO reserve espacio
            validator: (_) => null,

            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              filled: true,
              fillColor: AppColors.backgroundTextField,
              labelStyle: TextStyle(
                color: labelColor ?? AppColors.textPrimary,
                fontSize: 14,
              ),
              hintStyle: TextStyle(
                color: labelColor ?? AppColors.textPrimary,
                fontSize: 12,
              ),
              prefixIcon: icon,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),

              // Muy importante:
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              isDense: true,
            ),

            icon: Icon(
              Icons.keyboard_arrow_down,
              color: labelColor ?? AppColors.textPrimary,
            ),
            style: TextStyle(
              color: labelColor ?? AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),

            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(toLabel?.call(item) ?? item.name),
              );
            }).toList(),
          ),
        ),

        // === Error dibujado manualmente ===
        /* if (error != null)
          const Padding(
            padding: EdgeInsets.only(top: 2, left: 4),
            child: Text(
              "Required",
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
                height: 1,
              ),
            ),
          ), */
      ],
    );
  }
}

