import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
  int count = 1;
  List<FortuneItem> itemList = [
    FortuneItem(child: Text('Han Solo')),
    FortuneItem(child: Text('Yoda')),
    FortuneItem(child: Text('Obi-Wan Kenobi')),
  ];
  void addItem() {
    // setState(() {
    itemList.add(FortuneItem(child: Text('Item #$count')));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Spin Around',
      debugShowCheckedModeBanner: false,
      routerConfig: Routes.router,
      // home: Scaffold(
      //   body: Column(
      //     children: [
      //       Expanded(
      //         child: FortuneWheel(
      //           physics: CircularPanPhysics(
      //             duration: Duration(seconds: 1),
      //             curve: Curves.decelerate,
      //           ),
      //           hapticImpact: HapticImpact.medium,
      //           onFling: () {
      //             // controller.add(1);
      //           },
      //           // selected: controller.stream,
      //           items: itemList,
      //         ),
      //       ),
      //       ElevatedButton(
      //         onPressed: addItem,
      //         child: Text('Add Item'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
