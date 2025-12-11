// jump_details_section.dart
import 'package:flutter/material.dart';
import 'package:jumpbook/theme/app_colors.dart';
import 'package:jumpbook/widgets/inputs/jb_input_group.dart';
import 'package:jumpbook/widgets/inputs/jb_input_row.dart';
import 'package:jumpbook/widgets/layout/custom_container.dart';
// ... Importaciones necesarias (JBFieldGroup, JBFieldRow, etc.)

class JumpDetailsSection extends StatelessWidget {
  final TextEditingController exitAltitudeCtrl;
  final TextEditingController speedMaxCtrl;
  final TextEditingController deploymentCtrl;
  final TextEditingController freefallCtrl;
  final VoidCallback onChanged;

  const JumpDetailsSection({
    super.key, 
    required this.exitAltitudeCtrl,
    required this.speedMaxCtrl,
    required this.deploymentCtrl,
    required this.freefallCtrl,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return JumpbookCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 12,
      color: AppColors.card,
      child: JBFieldGroup(
        children: [
          JBFieldRow(
            hintText: '10000',
            label: "Exit altitude (ft)",
            controller: exitAltitudeCtrl,
            keyboardType: TextInputType.number,
            onChanged: (_) => onChanged(),
          ),
          JBFieldRow(
            hintText: '200',
            label: "Speed max (km/h)",
            controller: speedMaxCtrl,
            keyboardType: TextInputType.number,
            onChanged: (_) => onChanged(),
          ),
          JBFieldRow(
            hintText: '4000',
            label: "Deployment Altitude (ft)",
            controller: deploymentCtrl,
            keyboardType: TextInputType.number,
            onChanged: (_) => onChanged(),
          ),
          JBFieldRow(
            hintText: '50',
            label: "Freefall time (Seconds)",
            controller: freefallCtrl,
            keyboardType: TextInputType.number,
            onChanged: (_) => onChanged(),
          ),
        ],
      ),
    );
  }
}