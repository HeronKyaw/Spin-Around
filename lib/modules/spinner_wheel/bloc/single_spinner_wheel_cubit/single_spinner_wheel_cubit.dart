import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_around/data/models/spinner_wheel_model.dart';

class SingleSpinnerWheelCubit extends Cubit<SpinnerWheelModel> {
  SingleSpinnerWheelCubit(super.wheelModel);

  // Emit a new state with updated title
  void updateTitle(String newTitle) {
    emit(SpinnerWheelModel(title: newTitle, itemList: state.itemList));
  }

  // Emit a new state with updated items
  void updateItems(List<String> newItems) {
    emit(SpinnerWheelModel(title: state.title, itemList: newItems));
  }
}
