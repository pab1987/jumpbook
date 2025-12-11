// jump_gear_mode_section.dart
import 'package:flutter/material.dart';
import 'package:jumpbook/core/utils/string_utils.dart';
import 'package:jumpbook/models/canopy_sizes.dart';
import 'package:jumpbook/models/enums.dart';
import 'package:jumpbook/theme/app_colors.dart';
import 'package:jumpbook/widgets/inputs/jb_input_field.dart';
import 'package:jumpbook/widgets/inputs/jb_select_field.dart';
import 'package:jumpbook/widgets/inputs/jb_select_field_generic.dart';
import 'package:jumpbook/widgets/layout/custom_container.dart';
// ... Importaciones necesarias (JBSelectField, FlightMode, CanopySize, etc.)

class JumpGearAndModeSection extends StatelessWidget {
  final Key canopySizeKey;
  final int? selectedCanopySize;
  final void Function(int?) onCanopySizeChanged;

  final Key flightModeKey;
  final FlightMode? selectedFlightMode;
  final void Function(FlightMode?) onFlightModeChanged;

  final TextEditingController observationController;
  final VoidCallback onObservationChanged;

  const JumpGearAndModeSection({
    super.key,
    required this.canopySizeKey,
    required this.selectedCanopySize,
    required this.onCanopySizeChanged,
    required this.flightModeKey,
    required this.selectedFlightMode,
    required this.onFlightModeChanged,
    required this.observationController,
    required this.onObservationChanged,
  });

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // === Main Canopy ===
            Expanded(
              child: JumpbookCard(
                padding: const EdgeInsets.all(8.0),
                borderRadius: 12,
                color: AppColors.card,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Canopy Size', style: titleStyle),

                    SizedBox(
                      width: double.infinity,
                      child: JBSelectField<int>(
                        key: canopySizeKey,
                        height: 40,
                        hint: "Select",
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/icons/canopy.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                        value: selectedCanopySize,
                        items: CanopySize.canopySizes,
                        toLabel: (int item) => item.toString(),
                        onChanged: onCanopySizeChanged,
                        validator: (v) => v == null ? "Required" : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 10),

            // === Flight Mode ===
            Expanded(
              child: JumpbookCard(
                padding: const EdgeInsets.all(8.0),
                borderRadius: 12,
                color: AppColors.card,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Flight Mode', style: titleStyle),
                    SizedBox(
                      width: double.infinity,
                      child: JBSelectFieldEnum(
                        key: flightModeKey,
                        height: 40,
                        hint: "Select",
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/icons/freefly.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                        value: selectedFlightMode,
                        items: FlightMode.values,
                        toLabel: (item) => enumToTitle(item.name),
                        onChanged: onFlightModeChanged,
                        validator: (v) => v == null ? "Required" : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8.0),

        // === Observations ===
        const SizedBox(height: 8),
        Text(
          'Observations',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        JumpbookCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: JBInputField(
              hintColor: AppColors.textSecondary,
              textColor: AppColors.textPrimary,
              controller: observationController,
              hint: 'About your jump...',
              keyboard: TextInputType.text,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              onChanged: (_) => onObservationChanged(),
            ),
          ),
        ),
      ],
    );
  }
}
