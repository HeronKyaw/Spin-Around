import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'spinner_wheel_list_state.dart';

class SpinnerWheelListCubit extends Cubit<SpinnerWheelListState> {
  SpinnerWheelListCubit() : super(SpinnerWheelListInitial());
}
