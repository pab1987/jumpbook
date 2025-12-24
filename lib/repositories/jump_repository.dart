import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JumpRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Get current user's UID
  String get _uid => _auth.currentUser!.uid;

  // Save a new jump to Firestore
  Future<void> saveJump(Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(_uid).collection('jumps').add({
      ...data,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Retrieve a stream of jumps ordered by date
  Stream<List<Map<String, dynamic>>> jumpsStream() {
    return _firestore
        .collection('users')
        .doc(_uid)
        .collection('jumps')
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => {'id': doc.id, ...doc.data()})
              .toList(),
        );
  }

  // Delete a jump by its ID
  Future<void> deleteJump(String jumpId) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('jumps')
        .doc(jumpId)
        .delete();
  }
}
