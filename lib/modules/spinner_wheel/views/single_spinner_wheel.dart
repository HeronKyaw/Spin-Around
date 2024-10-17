import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_around/data/models/spinner_wheel_model.dart';
import 'package:spin_around/modules/spinner_wheel/bloc/single_spinner_wheel_cubit/single_spinner_wheel_cubit.dart';
import 'package:spin_around/modules/spinner_wheel/widgets/spinner_wheel_widget.dart';

class SingleSpinnerWheel extends StatelessWidget {
  final SpinnerWheelModel wheelModel;
  final bool isNew;

  SingleSpinnerWheel({
    super.key,
    required this.wheelModel,
    required this.isNew,
  });

  static final String tag = 'single-spinner-wheel';

  final StreamController<int> controller = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          wheelModel.title,
        ),
        automaticallyImplyLeading: true,
        previousPageTitle: 'Home',
        trailing: CupertinoButton(
          padding: EdgeInsets.only(right: 15),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return Text('Hello');
              },
            );
          },
          child: const Text('Edit'),
        ),
      ),
      child: BlocBuilder<SingleSpinnerWheelCubit, SpinnerWheelModel>(
        builder: (context, wheelModel) {
          return SpinnerWheelWidget(
            wheelModel: wheelModel,
            controller: controller,
          );
        },
      ),
    );
  }
}
