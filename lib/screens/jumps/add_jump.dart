import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jumpbook/models/enums.dart';
import 'package:jumpbook/models/jump_model.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_details_section.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_gear_mode_section.dart';
import 'package:jumpbook/theme/app_colors.dart';
import 'package:jumpbook/screens/home/widgets/jumpbook_app_bar.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_metadata_section.dart';
import 'package:jumpbook/screens/jumps/add_jump/add_jump_notifier.dart';

class AddJumpScreen extends ConsumerStatefulWidget {
  final Jump? existingJump;
  const AddJumpScreen({super.key, this.existingJump});

  @override
  ConsumerState<AddJumpScreen> createState() => _AddJumpScreenState();
}

class _AddJumpScreenState extends ConsumerState<AddJumpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores
  final _dateController = TextEditingController();
  final _observationController = TextEditingController();
  final exitAltitudeCtrl = TextEditingController();
  final speedMaxCtrl = TextEditingController();
  final deploymentCtrl = TextEditingController();
  final freefallCtrl = TextEditingController();
  final canopyTimeCtrl = TextEditingController();

  // Keys para forzar reinicio de selects
  Key _aircraftKey = UniqueKey();
  Key _dropzoneKey = UniqueKey();
  Key _jumpTypeKey = UniqueKey();
  Key _canopySizeKey = UniqueKey();
  Key _flightModeKey = UniqueKey();

  @override
  void initState() {
    super.initState();

    final notifier = ref.read(addJumpProvider.notifier);

    // Si es edición, llenamos los valores
    if (widget.existingJump != null) {
      final jump = widget.existingJump!;
      _dateController.text =
          "${jump.date.year}-${jump.date.month}-${jump.date.day}";
      exitAltitudeCtrl.text = jump.exitAltitude;
      speedMaxCtrl.text = jump.speedMax;
      deploymentCtrl.text = jump.deployment;
      freefallCtrl.text = jump.freefall;
      canopyTimeCtrl.text = jump.canopyTime;
      _observationController.text = jump.observations;

      // Deferimos las modificaciones del provider hasta que termine el primer frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        notifier.setAircraft(
          Aircraft.values.firstWhere((e) => e.name == jump.aircraft),
        );
        notifier.setDropzone(
          Dropzone.values.firstWhere((e) => e.name == jump.dropzone),
        );
        notifier.setJumpType(
          JumpType.values.firstWhere((e) => e.name == jump.jumpType),
        );
        notifier.setFlightMode(
          FlightMode.values.firstWhere((e) => e.name == jump.flightMode),
        );
        notifier.setCanopySize(jump.canopySize);
        notifier.setDate(jump.date);
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _observationController.dispose();
    exitAltitudeCtrl.dispose();
    speedMaxCtrl.dispose();
    deploymentCtrl.dispose();
    freefallCtrl.dispose();
    canopyTimeCtrl.dispose();
    super.dispose();
  }

  void _regenerateKeys() {
    // Usamos setState sólo para renovar claves de widgets (UI-only)
    setState(() {
      _aircraftKey = UniqueKey();
      _dropzoneKey = UniqueKey();
      _jumpTypeKey = UniqueKey();
      _canopySizeKey = UniqueKey();
      _flightModeKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addJumpProvider);
    final notifier = ref.read(addJumpProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const JumpbookAppBar(
        icon: Icons.arrow_back_ios_new_rounded,
        title: 'Add Jump',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // METADATA - ahora pasamos las keys requeridas
              JumpMetadataSection(
                aircraftKey: _aircraftKey,
                dropzoneKey: _dropzoneKey,
                jumpTypeKey: _jumpTypeKey,
                dateController: _dateController,
                selectedAircraft: state.aircraft,
                onAircraftChanged: (value) => notifier.setAircraft(value!),
                selectedDropzone: state.dropzone,
                onDropzoneChanged: (value) => notifier.setDropzone(value!),
                selectedJumpType: state.jumpType,
                onJumpTypeChanged: (value) => notifier.setJumpType(value!),
                onDateSelected: (date) {
                  notifier.setDate(date);
                },
              ),

              const SizedBox(height: 12),

              // DETAILS
              JumpDetailsSection(
                exitAltitudeCtrl: exitAltitudeCtrl,
                speedMaxCtrl: speedMaxCtrl,
                deploymentCtrl: deploymentCtrl,
                freefallCtrl: freefallCtrl,
                canopyTimeCtrl: canopyTimeCtrl,
                onChanged: () {
                  // si necesitas validar en caliente, hazlo aquí
                },
              ),

              const SizedBox(height: 12),

              // GEAR & MODE - también pasamos keys
              JumpGearAndModeSection(
                canopySizeKey: _canopySizeKey,
                selectedCanopySize: state.canopySize,
                onCanopySizeChanged: (value) => notifier.setCanopySize(value!),
                flightModeKey: _flightModeKey,
                selectedFlightMode: state.flightMode,
                onFlightModeChanged: (value) => notifier.setFlightMode(value!),
                observationController: _observationController,
                onObservationChanged: () {
                  // ...
                },
              ),

              const SizedBox(height: 24),

              // BOTÓN GUARDAR
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.addButton,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: state.isSaving || !state.isValid
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            final saved = await notifier.saveJump(
                              jumpId: widget.existingJump?.id,
                              exitAltitude: exitAltitudeCtrl.text,
                              speedMax: speedMaxCtrl.text,
                              deployment: deploymentCtrl.text,
                              freefall: freefallCtrl.text,
                              canopyTime: canopyTimeCtrl.text,
                              observations: _observationController.text,
                            );

                            if (saved) {
                              // Limpiar controllers locales y regenerar keys para reiniciar selects
                              _formKey.currentState?.reset();
                              _dateController.clear();
                              _observationController.clear();
                              exitAltitudeCtrl.clear();
                              speedMaxCtrl.clear();
                              deploymentCtrl.clear();
                              freefallCtrl.clear();
                              canopyTimeCtrl.clear();

                              _regenerateKeys();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Jump saved successfully!'),
                                ),
                              );
                            } else {
                              final errorMsg =
                                  ref.read(addJumpProvider).error ??
                                  'Error saving jump';
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(errorMsg)));
                            }
                          }
                        },
                  child: state.isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Save Jump',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              if (state.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    state.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
