import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:spin_around/firebase_options.dart';
import 'package:spin_around/utils/constant/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SpinAroundApp());
}

class SpinAroundApp extends StatelessWidget {
  const SpinAroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Spin Around',
      debugShowCheckedModeBanner: false,
      initialRoute: '/auth',
      getPages: AppRoute.getPages,
    );
  }
}