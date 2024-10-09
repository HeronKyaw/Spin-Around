import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'single_spinner_wheel_state.dart';

class SingleSpinnerWheelCubit extends Cubit<SingleSpinnerWheelState> {
  SingleSpinnerWheelCubit() : super(SingleSpinnerWheelInitial());

}
