import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spin_around/data/models/spinner_wheel_model.dart';
import 'package:spin_around/modules/spinner_wheel/bloc/single_spinner_wheel_cubit/single_spinner_wheel_cubit.dart';
import 'package:spin_around/modules/spinner_wheel/widgets/spinner_wheel_widget.dart';
import 'package:spin_around/modules/spinner_wheel/widgets/update_wheel_page.dart';

class SingleSpinnerWheel extends StatefulWidget {
  const SingleSpinnerWheel({
    super.key,
  });

  static final String tag = 'single-spinner-wheel';

  @override
  State<SingleSpinnerWheel> createState() => _SingleSpinnerWheelState();
}

class _SingleSpinnerWheelState extends State<SingleSpinnerWheel> {
  final StreamController<int> controller = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleSpinnerWheelCubit, SpinnerWheelModel>(
      builder: (context, state) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(
              state.title,
            ),
            previousPageTitle: 'Home',
            trailing: CupertinoButton(
              padding: EdgeInsets.only(right: 15),
              onPressed: () {
                showEditModal(context, state);
              },
              child: const Text('Edit'),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SpinnerWheelWidget(
              wheelModel: state,
              controller: controller,
            ),
          ),
        );
      },
    );
  }

  void showEditModal(BuildContext context, SpinnerWheelModel wheelModel) {
    context
        .pushNamed(
      UpdateWheelPage.tag,
      extra: wheelModel,
    )
        .then((wheel) {
      if (wheel is SpinnerWheelModel && context.mounted) {
        context.read<SingleSpinnerWheelCubit>().updateWheel(wheel);
      }
    });
  }
}
