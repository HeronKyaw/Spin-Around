import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_around/data/models/spinner_wheel_model.dart';

class SingleSpinnerWheelCubit extends Cubit<SpinnerWheelModel> {
  SingleSpinnerWheelCubit(super.wheelModel);

  // Update both title and items at once
  void updateWheel(SpinnerWheelModel wheelModel) {
    emit(wheelModel);
  }
}
