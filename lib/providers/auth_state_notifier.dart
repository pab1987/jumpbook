import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthStateNotifier extends ChangeNotifier {
  late final StreamSubscription<User?> _sub;

  AuthStateNotifier() {
    _sub = FirebaseAuth.instance.authStateChanges().listen((_) {
      notifyListeners(); // 🔥 GoRouter se refresca
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
