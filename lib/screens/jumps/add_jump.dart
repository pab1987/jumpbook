import 'package:flutter/material.dart';
import 'package:jumpbook/models/enums.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_details_section.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_gear_mode_section.dart';
import 'package:jumpbook/theme/app_colors.dart';
import 'package:jumpbook/screens/home/widgets/jumpbook_app_bar.dart';
import 'package:jumpbook/screens/jumps/widgets/jump_metadata_section.dart';

class AddJumpScreen extends StatefulWidget {
  const AddJumpScreen({super.key});

  @override
  State<AddJumpScreen> createState() => _AddJumpScreenState();
}

class _AddJumpScreenState extends State<AddJumpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _observationController = TextEditingController();
  final exitAltitudeCtrl = TextEditingController();
  final speedMaxCtrl = TextEditingController();
  final deploymentCtrl = TextEditingController();
  final freefallCtrl = TextEditingController();

  // Variables de Estado (Selección)
  Aircraft? _selectedAircraft;
  Dropzone? _selectedDropzone;
  JumpType? _selectedJumpType;
  FlightMode? _selectedFlightMode;
  int? _selectedCanopySize;

  // Claves para forzar el reinicio de los Selectors
  Key _aircraftKey = UniqueKey();
  Key _dropzoneKey = UniqueKey();
  Key _jumpTypeKey = UniqueKey();
  Key _canopySizeKey = UniqueKey();
  Key _flightModeKey = UniqueKey();


  // Función para limpiar todos los campos
  void _clearForm() {
    setState(() {
      // Limpiar controladores de texto
      _dateController.clear();
      exitAltitudeCtrl.clear();
      speedMaxCtrl.clear();
      deploymentCtrl.clear();
      freefallCtrl.clear();
      _observationController.clear();

      // Limpiar variables de selección
      _selectedAircraft = null;
      _selectedDropzone = null;
      _selectedJumpType = null;
      _selectedFlightMode = null;
      _selectedCanopySize = null;

      // Forzar reconstrucción de Selectores (genera nuevas claves)
      _aircraftKey = UniqueKey();
      _dropzoneKey = UniqueKey();
      _jumpTypeKey = UniqueKey();
      _canopySizeKey = UniqueKey();
      _flightModeKey = UniqueKey();

      _formKey.currentState?.reset();
    });
  }

  // Función o Getter que verifica si TODOS los campos obligatorios tienen datos
  bool get isFormValid {
    final textControllersValid =
        _dateController.text.isNotEmpty &&
        exitAltitudeCtrl.text.isNotEmpty &&
        speedMaxCtrl.text.isNotEmpty &&
        deploymentCtrl.text.isNotEmpty &&
        freefallCtrl.text.isNotEmpty &&
        _observationController.text.isNotEmpty;

    final selectionFieldsValid =
        _selectedAircraft != null &&
        _selectedDropzone != null &&
        _selectedJumpType != null &&
        _selectedCanopySize != null &&
        _selectedFlightMode != null;

    return textControllersValid && selectionFieldsValid;
  }

  // Función de guardado (con impresión de datos)
  void _saveJump() {
    if (_formKey.currentState!.validate()) {
      print("--- INICIO DE REGISTRO DE SALTO ---");
      print("Aeronave: ${_selectedAircraft?.name ?? 'N/A'}");
      print("Dropzone: ${_selectedDropzone?.name ?? 'N/A'}");
      print("Tipo de Salto: ${_selectedJumpType?.name ?? 'N/A'}");
      print("Modo de Vuelo: ${_selectedFlightMode?.name ?? 'N/A'}");
      print("Canopy Size: ${_selectedCanopySize ?? 'N/A'} sq ft");
      print("Fecha: ${_dateController.text}");
      print("Alt. de Salida: ${exitAltitudeCtrl.text} ft");
      print("Velocidad Máx: ${speedMaxCtrl.text} km/h");
      print("Alt. de Apertura: ${deploymentCtrl.text} ft");
      print("Tiempo Caída Libre: ${freefallCtrl.text} segundos");
      print("Observaciones: ${_observationController.text}");
      print("--- FIN DE REGISTRO DE SALTO ---");

      // Limpiar después de guardar
      _clearForm();
    }
  }

  @override
  Widget build(BuildContext context) {
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
              // 1. Metadatos del Salto (Fecha, Aeronave, DZ, Tipo)
              JumpMetadataSection(
                dateController: _dateController,
                aircraftKey: _aircraftKey,
                selectedAircraft: _selectedAircraft,
                onAircraftChanged: (value) => setState(() => _selectedAircraft = value),
                dropzoneKey: _dropzoneKey,
                selectedDropzone: _selectedDropzone,
                onDropzoneChanged: (value) => setState(() => _selectedDropzone = value),
                jumpTypeKey: _jumpTypeKey,
                selectedJumpType: _selectedJumpType,
                onJumpTypeChanged: (value) => setState(() => _selectedJumpType = value),
                onDateChanged: () => setState(() {}), // Trigger al seleccionar fecha
              ),

              const SizedBox(height: 12),

              // 2. Detalles de Caída Libre (Altitudes, Velocidad, Tiempo)
              JumpDetailsSection(
                exitAltitudeCtrl: exitAltitudeCtrl,
                speedMaxCtrl: speedMaxCtrl,
                deploymentCtrl: deploymentCtrl,
                freefallCtrl: freefallCtrl,
                onChanged: () => setState(() {}), // Trigger al escribir
              ),

              const SizedBox(height: 12),

              // 3. Equipo y Modo de Vuelo (Canopy, Flight Mode, Observaciones)
              JumpGearAndModeSection(
                canopySizeKey: _canopySizeKey,
                selectedCanopySize: _selectedCanopySize,
                onCanopySizeChanged: (value) => setState(() => _selectedCanopySize = value),
                flightModeKey: _flightModeKey,
                selectedFlightMode: _selectedFlightMode,
                onFlightModeChanged: (value) => setState(() => _selectedFlightMode = value),
                observationController: _observationController,
                onObservationChanged: () => setState(() {}), // Trigger al escribir
              ),

              const SizedBox(height: 24),

              // === BOTÓN GUARDAR ===
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
                  onPressed: isFormValid ? _saveJump : null,
                  child: const Text(
                    'Save Jump',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}