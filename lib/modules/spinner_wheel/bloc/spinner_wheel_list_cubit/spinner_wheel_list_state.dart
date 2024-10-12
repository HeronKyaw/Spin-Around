part of 'spinner_wheel_list_cubit.dart';

sealed class SpinnerWheelListState {}

final class SpinnerWheelListInitial extends SpinnerWheelListState {}

final class SpinnerWheelListFetched extends SpinnerWheelListState {
  List<SpinnerWheelModel> wheelList;

  SpinnerWheelListFetched(this.wheelList);
}
