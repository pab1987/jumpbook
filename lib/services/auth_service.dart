import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// EMAIL + PASSWORD LOGIN
  static Future<UserCredential?> loginWithEmail(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } catch (e) {
      print("Login email error: $e");
      return null;
    }
  }

  /// EMAIL + PASSWORD REGISTER
  static Future<UserCredential?> registerWithEmail(
    String email,
    String password,
    String name,
  ) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await _saveUserData(cred.user!.uid, {
        "name": name,
        "email": email,
        "createdAt": DateTime.now(),
      });

      return cred;
    } catch (e) {
      print("Register error: $e");
      return null;
    }
  }

  /// GOOGLE LOGIN
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      // NOTE: google_sign_in v7+ uses a singleton API. Initialize once
      // (preferably at app startup). Here we ensure initialization doesn't
      // fail if already initialized.
      try {
        await GoogleSignIn.instance.initialize();
      } catch (_) {}

      final gUser = await GoogleSignIn.instance.authenticate();

      final gAuth = gUser.authentication;

      // The newer plugin exposes an idToken on authentication. If you need
      // an access token for additional Google APIs, obtain it via
      // `GoogleSignIn.instance.authorizationClient`.
      final credential = GoogleAuthProvider.credential(idToken: gAuth.idToken);

      final userCred = await _auth.signInWithCredential(credential);

      await _saveUserData(userCred.user!.uid, {
        "name": userCred.user!.displayName,
        "email": userCred.user!.email,
        "photo": userCred.user!.photoURL,
      });

      return userCred;
    } catch (e) {
      print("Google error: $e");
      return null;
    }
  }

  /// APPLE LOGIN
  static Future<UserCredential?> signInWithApple() async {
    try {
      final appleCred = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauth = OAuthProvider("apple.com").credential(
        idToken: appleCred.identityToken,
        accessToken: appleCred.authorizationCode,
      );

      final result = await _auth.signInWithCredential(oauth);

      await _saveUserData(result.user!.uid, {
        "name": "${appleCred.givenName ?? ""} ${appleCred.familyName ?? ""}"
            .trim(),
        "email": appleCred.email ?? result.user!.email,
      });

      return result;
    } catch (e) {
      print("Apple login error: $e");
      return null;
    }
  }

  /// LOGOUT
  static Future<void> logout() async {
    await GoogleSignIn.instance.signOut();
    return _auth.signOut();
  }

  /// SAVE USER DATA IN FIRESTORE
  static Future<void> _saveUserData(
    String uid,
    Map<String, dynamic> data,
  ) async {
    await _db.collection("users").doc(uid).set(data, SetOptions(merge: true));
  }
}
