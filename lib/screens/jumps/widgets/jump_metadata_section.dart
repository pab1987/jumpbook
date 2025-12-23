// jump_metadata_section.dart
import 'package:flutter/material.dart';
import 'package:jumpbook/core/utils/string_utils.dart';
import 'package:jumpbook/models/enums.dart';
import 'package:jumpbook/theme/app_colors.dart';
import 'package:jumpbook/widgets/inputs/jb_input_field.dart';
import 'package:jumpbook/widgets/inputs/jb_select_field.dart';
import 'package:jumpbook/widgets/layout/custom_container.dart';
// ... Importaciones necesarias (AppColors, Dropzone, Aircraft, etc.)

class JumpMetadataSection extends StatelessWidget {
  final TextEditingController dateController;
  final void Function(DateTime date) onDateSelected;

  final Key aircraftKey;
  final Aircraft? selectedAircraft;
  final void Function(Aircraft?) onAircraftChanged;

  final Key dropzoneKey;
  final Dropzone? selectedDropzone;
  final void Function(Dropzone?) onDropzoneChanged;

  final Key jumpTypeKey;
  final JumpType? selectedJumpType;
  final void Function(JumpType?) onJumpTypeChanged;

  const JumpMetadataSection({
    super.key,
    required this.dateController,
    required this.onDateSelected,
    required this.aircraftKey,
    required this.selectedAircraft,
    required this.onAircraftChanged,
    required this.dropzoneKey,
    required this.selectedDropzone,
    required this.onDropzoneChanged,
    required this.jumpTypeKey,
    required this.selectedJumpType,
    required this.onJumpTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    );

    return JumpbookCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 12,
      color: AppColors.card,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === INPUT: Date ===
                Text('Date', style: titleStyle),
                SizedBox(
                  width: double.infinity,
                  child: JBInputField(
                    height: 40,
                    controller: dateController,
                    hint: 'Select a date',
                    icon: Icons.calendar_month_rounded,
                    readOnly: true,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );

                      if (picked != null) {
                        // UI (solo mostrar)
                        dateController.text =
                            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';

                        // 🔥 FUENTE DE VERDAD
                        onDateSelected(picked);
                      }
                    },

                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                ),
                const SizedBox(height: 16),
                // === INPUT: Aircraft ===
                Text('Aircraft', style: titleStyle),
                SizedBox(
                  width: double.infinity,
                  child: JBSelectFieldEnum(
                    key: aircraftKey,
                    height: 40,
                    hint: "Select",
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/icons/plane.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    value: selectedAircraft,
                    items: Aircraft.values,
                    toLabel: (item) => enumToTitle(item.name),
                    onChanged: onAircraftChanged,
                    validator: (v) => v == null ? "Required" : null,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === INPUT: Dropzone ===
                // ... (El widget Text para 'Dropzone')
                Text('Dropzone', style: titleStyle),

                SizedBox(
                  width: double.infinity,
                  child: JBSelectFieldEnum(
                    key: dropzoneKey,
                    height: 40,
                    hint: "Dz",
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/icons/dropzone.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    value: selectedDropzone,
                    items: Dropzone.values,
                    toLabel: (item) => enumToTitle(item.name),
                    onChanged: onDropzoneChanged,
                    validator: (v) => v == null ? "Required" : null,
                  ),
                ),
                const SizedBox(height: 16),
                // === INPUT: Jump Type ===
                // ... (El widget Text para 'Jump type')
                Text('Jump type', style: titleStyle),

                SizedBox(
                  width: double.infinity,
                  child: JBSelectFieldEnum(
                    key: jumpTypeKey,
                    height: 40,
                    hint: "Select",
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/icons/exit_freefall.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    value: selectedJumpType,
                    items: JumpType.values,
                    toLabel: (item) => enumToTitle(item.name),
                    onChanged: onJumpTypeChanged,
                    validator: (v) => v == null ? "Required" : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
