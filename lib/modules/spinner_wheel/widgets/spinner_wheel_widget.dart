import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:spin_around/data/models/spinner_wheel_model.dart';
import 'package:spin_around/global/custom_dialog.dart';

class SpinnerWheelWidget extends StatefulWidget {
  final SpinnerWheelModel wheelModel;
  final StreamController<int>? wheelController;
  final StreamController<bool>? ignorePointerController;
  final bool isIgnore;

  const SpinnerWheelWidget({
    super.key,
    required this.wheelModel,
    this.wheelController,
    this.ignorePointerController,
    this.isIgnore = false,
  });

  @override
  State<SpinnerWheelWidget> createState() => _SpinnerWheelWidgetState();
}

class _SpinnerWheelWidgetState extends State<SpinnerWheelWidget> {
  late StreamController<bool> ignorePointerController;

  int currentValue = 0;

  @override
  void initState() {
    super.initState();
    ignorePointerController =
        widget.ignorePointerController ?? StreamController<bool>.broadcast();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 400,
          child: FortuneWheel(
            rotationCount: 70,
            selected:
                widget.wheelController?.stream ?? const Stream<int>.empty(),
            animateFirst: false,
            onAnimationStart: () {
              ignorePointerController.add(true);
            },
            onAnimationEnd: () {
              ignorePointerController.add(false);
              CustomDialog.showWarningDialog(
                context,
                title: widget.wheelModel.itemList[currentValue],
              );
            },
            physics: CircularPanPhysics(
              duration: const Duration(seconds: 1),
              curve: Curves.decelerate,
            ),
            hapticImpact: HapticImpact.medium,
            onFling: () {
              currentValue =
                  Fortune.randomInt(0, widget.wheelModel.itemList.length);
              widget.wheelController?.add(
                currentValue,
              );
            },
            items: widget.wheelModel.itemList
                .map((w) => FortuneItem(child: Text(w)))
                .toList(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CupertinoButton.filled(
          onPressed: widget.isIgnore
              ? null
              : () {
                  widget.wheelController?.add(
                      Fortune.randomInt(0, widget.wheelModel.itemList.length));
                },
          child: Text('Spin'),
        ),
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
    ignorePointerController.close();
  }
}
