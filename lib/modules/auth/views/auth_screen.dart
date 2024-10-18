import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spin_around/config/app_config.dart';
import 'package:spin_around/global/custom_dialog.dart';
import 'package:spin_around/modules/auth/bloc/auth_cubit/auth_cubit.dart';
import 'package:spin_around/modules/auth/views/verify_email_screen.dart';
import 'package:spin_around/modules/home/views/home.dart';

class AuthScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  AuthScreen({super.key});

  static final String tag = 'auth';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            CustomDialog.showWarningDialog(
              context,
              title: state.mode == AuthMode.login
                  ? 'Login Failed'
                  : 'Sign Up Failed',
              body: state.errorMessage ?? 'An error occurred',
            );
          } else if (state is AuthSuccess) {
            final user = state.user;
            if (user.emailVerified) {
              context.pushReplacementNamed(Home.tag);
            } else {
              context.pushReplacementNamed(VerifyEmailScreen.tag);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'appLogo',
                    child: Image.asset(
                      'assets/icon/app-logo.png',
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 20),
                  CupertinoTextField(
                    controller: _emailController,
                    placeholder: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CupertinoColors.inactiveGray,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Password field with show/hide toggle
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          CupertinoTextField(
                            controller: _passwordController,
                            placeholder: 'Password',
                            obscureText: !state.isPasswordVisible,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: CupertinoColors.inactiveGray,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: Icon(
                              state.isPasswordVisible
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye,
                              color: CupertinoColors.systemGrey,
                            ),
                            onPressed: () {
                              context
                                  .read<AuthCubit>()
                                  .togglePasswordVisibility();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state.mode == AuthMode.signup) {
                        return Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            CupertinoTextField(
                              controller: _confirmPasswordController,
                              placeholder: 'Confirm Password',
                              obscureText: !state
                                  .isConfirmPasswordVisible, // Toggle confirm password visibility
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: CupertinoColors.inactiveGray,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Icon(
                                state.isConfirmPasswordVisible
                                    ? CupertinoIcons.eye_slash
                                    : CupertinoIcons.eye,
                                color: CupertinoColors.systemGrey,
                              ),
                              onPressed: () {
                                context
                                    .read<AuthCubit>()
                                    .toggleConfirmPasswordVisibility();
                              },
                            ),
                          ],
                        );
                      } else {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: CupertinoColors.activeBlue,
                              ),
                            ),
                            onPressed: () {
                              String email = _emailController.text.trim();
                              if (email.isNotEmpty) {
                                context.read<AuthCubit>().resetPassword(email);
                                CustomDialog.showWarningDialog(
                                  context,
                                  title: 'Password Reset',
                                  body:
                                      'A password reset link has been sent to your email.',
                                );
                              } else {
                                CustomDialog.showWarningDialog(
                                  context,
                                  title: 'Email Required',
                                  body:
                                      'Please enter your email to reset password.',
                                );
                              }
                            },
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return CupertinoActivityIndicator();
                      }

                      return CupertinoButton.filled(
                        onPressed: () {
                          // Dismiss the keyboard
                          FocusScope.of(context).unfocus();

                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();

                          if (state.mode == AuthMode.signup) {
                            String confirmPassword =
                                _confirmPasswordController.text.trim();
                            if (password != confirmPassword) {
                              // Show error if passwords don't match
                              CustomDialog.showWarningDialog(
                                context,
                                title: 'Password Mismatch',
                                body: 'Passwords do not match.',
                              );
                            } else {
                              context
                                  .read<AuthCubit>()
                                  .signUpWithEmail(email, password);
                            }
                          } else {
                            context
                                .read<AuthCubit>()
                                .signInWithEmail(email, password);
                          }
                        },
                        child: Text(
                            state.mode == AuthMode.login ? 'Login' : 'Sign Up'),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  CupertinoButton(
                    onPressed: () {
                      // Dismiss the keyboard when switching modes
                      FocusScope.of(context).unfocus();

                      // Clear the text fields when switching between login and sign-up
                      _emailController.clear();
                      _passwordController.clear();
                      _confirmPasswordController.clear();

                      context.read<AuthCubit>().toggleAuthMode();
                    },
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return Text(
                          state.mode == AuthMode.login
                              ? "Don't have an account? Sign Up"
                              : 'Already have an account? Login',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
