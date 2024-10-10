import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spin_around/config/app_config.dart';
import 'package:spin_around/data/models/spinner_wheel_model.dart';
import 'package:spin_around/global/editable_text_field/editabe_text_field_cubit.dart';
import 'package:spin_around/modules/auth/bloc/auth_cubit/auth_cubit.dart';
import 'package:spin_around/modules/profile/bloc/create_profile_cubit/create_profile_cubit.dart';
import 'package:spin_around/modules/profile/views/create_profile.dart';
import 'package:spin_around/modules/auth/views/splash_screen.dart';
import 'package:spin_around/modules/home/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:spin_around/modules/home/views/home.dart';
import 'package:spin_around/modules/spinner_wheel/bloc/single_spinner_wheel_cubit/single_spinner_wheel_cubit.dart';
import 'package:spin_around/modules/spinner_wheel/bloc/spinner_wheel_list_cubit/spinner_wheel_list_cubit.dart';
import 'package:spin_around/modules/spinner_wheel/views/single_spinner_wheel.dart';
import 'package:spin_around/modules/spinner_wheel/views/spinner_wheel_list_screen.dart';

class Routes {
  static final GoRouter router = GoRouter(
    initialLocation: '/single-spinner-wheel',
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
        name: SpinnerWheelListScreen.tag,
        path: '/spinner-wheel-list',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SpinnerWheelListCubit(),
            ),
          ],
          child: SpinnerWheelListScreen(),
        ),
      ),
      GoRoute(
          name: SingleSpinnerWheel.tag,
          path: '/single-spinner-wheel',
          builder: (context, state) {
            SpinnerWheelModel? wheelModel =
                state.extra as SpinnerWheelModel? ?? SpinnerWheelModel();
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SingleSpinnerWheelCubit(wheelModel),
                ),
                BlocProvider(
                  create: (_) => TitleCubit(),
                ),
              ],
              child: SingleSpinnerWheel(
                wheelModel: wheelModel,
                isNew: wheelModel.isEmpty,
              ),
            );
          }),
    ],
  );
}
