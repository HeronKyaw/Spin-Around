part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final AuthMode mode;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  const AuthState({
    this.isLoading = false,
    this.errorMessage,
    this.mode = AuthMode.login,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  @override
  List<Object?> get props => [isLoading, errorMessage, mode, isPasswordVisible, isConfirmPasswordVisible];
}

class AuthInitial extends AuthState {}
class LogoutSuccess extends AuthState {}
class EmailVerificationSent extends AuthState {}
class EmailNotVerified extends AuthState {}

class AuthLoading extends AuthState {
  const AuthLoading(AuthMode mode) : super(isLoading: true, mode: mode);
}

class AuthError extends AuthState {
  const AuthError(String errorMessage, AuthMode mode)
      : super(isLoading: false, errorMessage: errorMessage, mode: mode);
}

class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess({required this.user, required super.mode})
      : super(isLoading: false);

  @override
  List<Object?> get props => [...super.props, user];
}

