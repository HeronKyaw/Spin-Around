import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sheet/route.dart';
import 'package:spin_around/config/app_config.dart';
import 'package:spin_around/data/models/spinner_wheel_model.dart';
import 'package:spin_around/global/editable_text_field/editabe_text_field_cubit.dart';
import 'package:spin_around/modules/auth/bloc/auth_cubit/auth_cubit.dart';
import 'package:spin_around/modules/auth/views/auth_screen.dart';
import 'package:spin_around/modules/auth/views/verify_email_screen.dart';
import 'package:spin_around/modules/profile/bloc/create_profile_cubit/create_profile_cubit.dart';
import 'package:spin_around/modules/profile/views/create_profile.dart';
import 'package:spin_around/modules/auth/views/splash_screen.dart';
import 'package:spin_around/modules/home/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:spin_around/modules/home/views/home.dart';
import 'package:spin_around/modules/spinner_wheel/bloc/single_spinner_wheel_cubit/single_spinner_wheel_cubit.dart';
import 'package:spin_around/modules/spinner_wheel/bloc/update_wheel_cubit/update_wheel_cubit.dart';
import 'package:spin_around/modules/spinner_wheel/views/single_spinner_wheel.dart';
import 'package:spin_around/modules/spinner_wheel/widgets/update_wheel_page.dart';

class Routes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        name: SplashScreen.tag,
        path: '/',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(),
            ),
          ],
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        name: AuthScreen.tag,
        path: '/auth',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(),
            ),
          ],
          child: AuthScreen(),
        ),
      ),
      GoRoute(
        name: VerifyEmailScreen.tag,
        path: '/verify-email',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(),
            ),
          ],
          child: VerifyEmailScreen(),
        ),
      ),
      GoRoute(
        name: Home.tag,
        path: '/home',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => BottomNavCubit(),
            ),
          ],
          child: Home(),
        ),
      ),
      GoRoute(
        name: CreateProfile.tag,
        path: '/create-profile',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CreateProfileCubit(),
            ),
          ],
          child: CreateProfile(),
        ),
      ),
      GoRoute(
        name: SingleSpinnerWheel.tag,
        path: '/single-spinner-wheel',
        pageBuilder: (BuildContext context, GoRouterState state) {
          SpinnerWheelModel? wheelModel = state.extra as SpinnerWheelModel? ??
              SpinnerWheelModel(
                isNew: true,
              );
          return MaterialExtendedPage<void>(
            key: state.pageKey,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SingleSpinnerWheelCubit(wheelModel),
                ),
                BlocProvider(
                  create: (_) => TitleCubit(),
                ),
              ],
              child: SingleSpinnerWheel(),
            ),
          );
        },
        routes: <GoRoute>[
          GoRoute(
            name: UpdateWheelPage.tag,
            path: 'update-wheel',
            pageBuilder: (BuildContext context, GoRouterState state) {
              SpinnerWheelModel wheelModel = state.extra as SpinnerWheelModel;
              return CupertinoSheetPage<SpinnerWheelModel>(
                key: state.pageKey,
                child: BlocProvider(
                  create: (context) =>
                      UpdateWheelCubit(wheelModel.title, wheelModel.itemList),
                  child: UpdateWheelPage(
                    wheelModel: state.extra as SpinnerWheelModel,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
