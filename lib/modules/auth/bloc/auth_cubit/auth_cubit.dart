import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_around/config/app_config.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthInitial());

  // Toggle between login and sign-up mode
  void toggleAuthMode() {
    final newMode =
        state.mode == AuthMode.login ? AuthMode.signup : AuthMode.login;
    emit(AuthState(
      mode: newMode,
      isPasswordVisible: false,
      isConfirmPasswordVisible: false,
    ));
  }

  // Sign in with email and password
  Future<void> signInWithEmail(String email, String password) async {
    emit(AuthLoading(state.mode));
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        emit(AuthSuccess(
          mode: state.mode,
          user: userCredential.user!,
        ));
      } else {
        emit(AuthError(
          'Something went wrong!',
          state.mode,
        ));
      }
    } catch (e) {
      emit(AuthError(e.toString(), state.mode));
    }
  }

  // Register with email and password
  Future<void> signUpWithEmail(String email, String password) async {
    emit(AuthLoading(state.mode));
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        emit(AuthSuccess(
          mode: state.mode,
          user: userCredential.user!,
        ));
      } else {
        emit(AuthError(
          'Something went wrong!',
          state.mode,
        ));
      }
    } catch (e) {
      emit(AuthError(e.toString(), state.mode));
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    emit(AuthState(
      mode: state.mode,
      isPasswordVisible: !state.isPasswordVisible,
      isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      isLoading: state.isLoading,
    ));
  }

  // Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    emit(AuthState(
      mode: state.mode,
      isPasswordVisible: state.isPasswordVisible,
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
      isLoading: state.isLoading,
    ));
  }

  // Reset password via email
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      emit(AuthError(e.toString(), state.mode));
    }
  }

  // Logout method
  Future<void> logout() async {
    emit(AuthLoading(state.mode));
    try {
      await _auth.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      emit(AuthError(e.toString(), state.mode));
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      await user?.sendEmailVerification(); // Assuming you are using Firebase
      emit(EmailVerificationSent());
    } catch (e) {
      emit(AuthError(
        'Failed to send verification email.',
        state.mode,
      ));
    }
  }

  Future<void> checkEmailVerified() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      // Reload the user to get updated verification status
      await user?.reload();
      if (user != null && user.emailVerified) {
        emit(AuthSuccess(
          user: user,
          mode: state.mode,
        ));
      } else {
        emit(EmailNotVerified());
      }
    } catch (e) {
      emit(AuthError(
        'Failed to check verification status.',
        state.mode,
      ));
    }
  }
}
