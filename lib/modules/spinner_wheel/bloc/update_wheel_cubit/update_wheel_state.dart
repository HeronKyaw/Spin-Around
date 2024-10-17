part of 'update_wheel_cubit.dart';

class UpdateWheelState {
  final String title;
  final List<String> items;

  UpdateWheelState({required this.title, required this.items});

  UpdateWheelState copyWith({String? title, List<String>? items}) {
    return UpdateWheelState(
      title: title ?? this.title,
      items: items ?? this.items,
    );
  }
}