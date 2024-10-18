import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spin_around/global/custom_dialog.dart';
import 'package:spin_around/modules/auth/bloc/auth_cubit/auth_cubit.dart';
import 'package:spin_around/modules/home/views/home.dart';

class VerifyEmailScreen extends StatelessWidget {
  static final String tag = 'verify-email';

  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Email Verification'),
      ),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            final user = state.user;
            if (user.emailVerified) {
              context.pushReplacementNamed(Home.tag);
            }
          } else if (state is EmailNotVerified) {
            CustomDialog.showWarningDialog(
              context,
              title: 'Email Verification Status',
              body:
                  'You have not verified your account yet. If you do not receive the email, click on "Resend Verification Email" button.',
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Please verify your email address to proceed.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                CupertinoButton.filled(
                  onPressed: () {
                    // Resend verification email
                    context.read<AuthCubit>().sendEmailVerification();
                    CustomDialog.showWarningDialog(
                      context,
                      title: 'Verification Email Sent',
                      body: 'A verification email has been sent to your inbox.',
                    );
                  },
                  child: Text('Resend Verification Email'),
                ),
                SizedBox(height: 20),
                CupertinoButton(
                  onPressed: () {
                    // Trigger re-check of verification status
                    context.read<AuthCubit>().checkEmailVerified();
                  },
                  child: Text('I have verified my email'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
