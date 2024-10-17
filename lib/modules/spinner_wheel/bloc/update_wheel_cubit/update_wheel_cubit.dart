import 'package:bloc/bloc.dart';

part 'update_wheel_state.dart';

class UpdateWheelCubit extends Cubit<UpdateWheelState> {
  UpdateWheelCubit(String initialTitle, List<String> initialItems)
      : super(UpdateWheelState(title: initialTitle, items: initialItems));

  // Update wheel name
  void updateTitle(String title) {
    String updateTitle = title.isEmpty ? 'Untitled Wheel' : title;
    emit(state.copyWith(title: updateTitle));
  }

  // Add a new item to the list
  void addItem(String item) {
    final updatedItems = List<String>.from(state.items)..add(item);
    emit(state.copyWith(items: updatedItems));
  }

  // Remove an item by index
  void removeItem(int index) {
    final updatedItems = List<String>.from(state.items)..removeAt(index);
    emit(state.copyWith(items: updatedItems));
  }

  // Method to update a specific item in the list
  void updateItem(int index, String newItem) {
    final updatedItems = List<String>.from(state.items);
    updatedItems[index] = newItem;
    emit(state.copyWith(items: updatedItems));
  }
}
