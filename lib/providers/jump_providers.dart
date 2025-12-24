import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jumpbook/models/jump_model.dart';
import 'package:jumpbook/models/home_stats.dart';
import '../repositories/jump_repository.dart';

final jumpRepositoryProvider = Provider((ref) => JumpRepository());

final jumpsStreamProvider = StreamProvider<List<Jump>>((ref) {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('jumps')
      .orderBy('date', descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) => Jump.fromFirestore(doc.data(), doc.id))
            .toList(),
      );
});

// Provider for jump actions like edit and delete
final jumpActionsProvider = Provider((ref) {
  return ref.read(jumpRepositoryProvider);
});

// Provider que expone los HomeStats calculados a partir de la lista de saltos
final homeStatsProvider = Provider<HomeStats>((ref) {
  final jumpsAsync = ref.watch(jumpsStreamProvider);

  return jumpsAsync.when(
    data: (jumps) => computeStats(jumps),
    loading: () => HomeStats(
      canopyHours: 0.0,
      freeFallHours: 0.0,
      currentJumps: 0,
      targetJumps: 100,
      lastJumpDate: '',
      jpm: 0.0,
    ),
    error: (_, __) => HomeStats(
      canopyHours: 0.0,
      freeFallHours: 0.0,
      currentJumps: 0,
      targetJumps: 100,
      lastJumpDate: '',
      jpm: 0.0,
    ),
  );
});
