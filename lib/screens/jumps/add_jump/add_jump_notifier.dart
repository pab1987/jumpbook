// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_jump_state.dart';
import 'package:jumpbook/models/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final addJumpProvider = NotifierProvider<AddJumpNotifier, AddJumpState>(
  AddJumpNotifier.new,
);

class AddJumpNotifier extends Notifier<AddJumpState> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  AddJumpState build() => AddJumpState.empty;

  // setters
  void setAircraft(Aircraft v) => state = state.copyWith(aircraft: v);
  void setDropzone(Dropzone v) => state = state.copyWith(dropzone: v);
  void setJumpType(JumpType v) => state = state.copyWith(jumpType: v);
  void setFlightMode(FlightMode v) => state = state.copyWith(flightMode: v);
  void setCanopySize(int v) => state = state.copyWith(canopySize: v);
  void setDate(DateTime v) => state = state.copyWith(date: v);

  void reset() => state = AddJumpState.empty;

  Future<bool> saveJump({
    required String exitAltitude,
    required String speedMax,
    required String deployment,
    required String freefall,
    required String observations,
    required String canopyTime,
  }) async {
    // Validaciones de negocio claras
    if (!state.isValid) {
      state = state.copyWith(error: 'Please fill all required fields');
      return false;
    }

    if (state.date == null) {
      state = state.copyWith(error: 'Date is required');
      return false;
    }

    final user = _auth.currentUser;
    if (user == null) {
      state = state.copyWith(error: 'User not authenticated');
      return false;
    }

    try {
      state = state.copyWith(isSaving: true, error: null);

      final uid = user.uid;

      final data = {
        'aircraft': state.aircraft!.name,
        'dropzone': state.dropzone!.name,
        'jumpType': state.jumpType!.name,
        'flightMode': state.flightMode!.name,
        'canopySize': state.canopySize,
        'date': Timestamp.fromDate(state.date!),
        'exitAltitude': exitAltitude,
        'speedMax': speedMax,
        'deployment': deployment,
        'freefall': freefall,
        'canopyTime': canopyTime,
        'observations': observations,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection('users')
          .doc(uid)
          .collection('jumps')
          .add(data);

      print('✅ Salto guardado en Firestore');
      reset();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      print('❌ Error guardando salto: $e');
      return false;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}
