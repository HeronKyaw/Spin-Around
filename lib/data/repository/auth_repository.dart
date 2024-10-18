import 'package:firebase_auth/firebase_auth.dart';
import 'package:spin_around/utils/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  // Get current user
  User? get currentUser => _authService.currentUser;

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    return await _authService.signInWithEmailAndPassword(email, password);
  }

  // Register (sign up) with email and password
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    return await _authService.registerWithEmailAndPassword(email, password);
  }

  // Sign out
  Future<void> signOut() async {
    await _authService.signOut();
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    await _authService.resetPassword(email);
  }

  // Sign in anonymously
  Future<User?> signInAnonymously() async {
    return await _authService.signInAnonymously();
  }

  // Send email verification
  Future<void> sendEmailVerification() async {
    await _authService.sendEmailVerification();
  }

  // Update password
  Future<void> updatePassword(String newPassword) async {
    await _authService.updatePassword(newPassword);
  }

  // Delete account
  Future<void> deleteAccount() async {
    await _authService.deleteAccount();
  }

  // Reauthenticate with email/password
  Future<void> reauthenticateWithEmail(String email, String password) async {
    await _authService.reauthenticateWithEmail(email, password);
  }
}
