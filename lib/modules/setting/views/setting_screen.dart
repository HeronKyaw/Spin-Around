import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spin_around/modules/auth/bloc/auth_cubit/auth_cubit.dart';
import 'package:spin_around/modules/auth/views/auth_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            context.pushReplacementNamed(AuthScreen.tag);
          }
        },
        child: Center(
          child: CupertinoButton(
            child: Text('Logout'),
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).logout();
            },
          ),
        ),
      ),
    );
  }
}
