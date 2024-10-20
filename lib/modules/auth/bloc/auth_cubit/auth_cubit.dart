import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_around/config/app_config.dart';
import 'package:spin_around/data/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitial());

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
      User? user = await _authRepo.signInWithEmailAndPassword(email, password);
      if (user != null) {
        emit(AuthSuccess(
          mode: state.mode,
          user: user,
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
      User? user = await _authRepo.registerWithEmailAndPassword(email, password);
      if (user != null) {
        emit(AuthSuccess(
          mode: state.mode,
          user: user,
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
      await _authRepo.resetPassword(email);
    } catch (e) {
      emit(AuthError(e.toString(), state.mode));
    }
  }

  // Logout method
  Future<void> logout() async {
    emit(AuthLoading(state.mode));
    try {
      await _authRepo.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      emit(AuthError(e.toString(), state.mode));
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _authRepo.sendEmailVerification(); // Assuming you are using Firebase
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
      User? user = _authRepo.currentUser;
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

  Future<void> signInWithGoogle() async {
    try {
      User? user = await _authRepo.signInWithGoogle();
      if (user != null && user.emailVerified) {
        emit(AuthSuccess(
          user: user,
          mode: state.mode,
        ));
      } else {
        emit(AuthError(
          'Failed to sign in with Google.',
          state.mode,
        ));
      }
    } catch (e) {
      emit(AuthError(
        e.toString(),
        state.mode,
      ));
    }
  }
}
