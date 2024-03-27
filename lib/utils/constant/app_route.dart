import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:spin_around/view/auth/auth_screen.dart';
import 'package:spin_around/view/splash_screen.dart';

class AppRoute {
  static List<GetPage<dynamic>>? getPages = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/auth', page: () => AuthScreen()),
  ];
}
