//==============================================//
// ignore: dangling_library_doc_comments
/// Estado de agregar salto
//==============================================//

import 'package:jumpbook/models/enums.dart';

class AddJumpState {
  final Aircraft? aircraft;
  final Dropzone? dropzone;
  final JumpType? jumpType;
  final FlightMode? flightMode;
  final int? canopySize;
  final bool isSaving;
  final String? error;
  final DateTime? date;

  const AddJumpState({
    this.aircraft,
    this.dropzone,
    this.jumpType,
    this.flightMode,
    this.canopySize,
    this.isSaving = false,
    this.error,
    this.date,
  });

  bool get isValid =>
      aircraft != null &&
      dropzone != null &&
      jumpType != null &&
      flightMode != null &&
      canopySize != null;

  AddJumpState copyWith({
    DateTime? date,
    Aircraft? aircraft,
    Dropzone? dropzone,
    JumpType? jumpType,
    FlightMode? flightMode,
    int? canopySize,
    bool? isSaving,
    String? error,
  }) {
    return AddJumpState(
      date: date ?? this.date,
      aircraft: aircraft ?? this.aircraft,
      dropzone: dropzone ?? this.dropzone,
      jumpType: jumpType ?? this.jumpType,
      flightMode: flightMode ?? this.flightMode,
      canopySize: canopySize ?? this.canopySize,
      isSaving: isSaving ?? this.isSaving,
      error: error ?? this.error,
    );
  }

  static const empty = AddJumpState(date: null);
}
