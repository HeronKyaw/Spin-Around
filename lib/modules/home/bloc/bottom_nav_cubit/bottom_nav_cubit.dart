import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(HomeTab());

  void selectTab(int index) {
    switch (index) {
      case 0:
        emit(HomeTab());
        break;
      case 1:
        emit(SearchTab());
        break;
      case 2:
        emit(ProfileTab());
        break;
    }
  }
}
