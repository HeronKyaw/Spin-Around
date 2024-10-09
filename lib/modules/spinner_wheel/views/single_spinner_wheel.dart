import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_around/data/models/spinner_wheel_model.dart';
import 'package:spin_around/global/editable_text_field/editable_text_field.dart';
import 'package:spin_around/modules/spinner_wheel/bloc/single_spinner_wheel_cubit/single_spinner_wheel_cubit.dart';

class SingleSpinnerWheel extends StatelessWidget {
  final SpinnerWheelModel wheelModel;
  final bool isNew;
  const SingleSpinnerWheel({
    super.key,
    required this.wheelModel,
    required this.isNew,
  });
  static final String tag = 'single-spinner-wheel';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: EditableTitleWidget(
          initialTitle: wheelModel.title,
          onTitleChanged: (value) {
            context.read<SingleSpinnerWheelCubit>().updateTitle(value);
          },
        ),
        actions: [],
      ),
      body: BlocBuilder<SingleSpinnerWheelCubit, SpinnerWheelModel>(
        builder: (context, wheelModel) {
          return Center(child: Text(wheelModel.title));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {},
      ),
    );
  }
}
