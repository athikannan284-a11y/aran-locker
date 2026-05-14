import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(String, int?) codeSent,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<UserCredential> signInWithCredential(PhoneAuthCredential credential) async {
    return await _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
