import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:spin_around/config/routes.dart';
import 'package:spin_around/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DatabaseHelper.initHive();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SpinAroundApp());
}

class SpinAroundApp extends StatefulWidget {
  const SpinAroundApp({super.key});

  @override
  State<SpinAroundApp> createState() => _SpinAroundAppState();
}

class _SpinAroundAppState extends State<SpinAroundApp> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      title: 'Spin Around',
      debugShowCheckedModeBanner: false,
      routerConfig: Routes.router,
    );
  }
}
