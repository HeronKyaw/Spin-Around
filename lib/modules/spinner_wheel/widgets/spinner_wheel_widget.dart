import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:spin_around/data/models/spinner_wheel_model.dart';

class SpinnerWheelWidget extends StatelessWidget {
  final SpinnerWheelModel wheelModel;
  final StreamController<int>? controller;
  const SpinnerWheelWidget({
    super.key,
    required this.wheelModel,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FortuneWheel(
        rotationCount: 70,
        selected: controller?.stream ?? const Stream<int>.empty(),
        animateFirst: false,
        physics: CircularPanPhysics(
          duration: Duration(seconds: 1),
          curve: Curves.decelerate,
        ),
        hapticImpact: HapticImpact.medium,
        onFling: () {
          controller?.add(Fortune.randomInt(0, wheelModel.itemList.length));
        },
        onAnimationStart: () {},
        items: wheelModel.itemList
            .map((w) => FortuneItem(child: Text(w)))
            .toList(),
      ),
    );
  }
}
