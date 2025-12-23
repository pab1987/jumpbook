import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jumpbook/models/jump_model.dart';
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
