import 'package:flutter_bloc/flutter_bloc.dart';

class TitleCubit extends Cubit<bool> {
  TitleCubit() : super(false);

  void toggleEditing() => emit(!state);
}

class TextCubit extends Cubit<String> {
  TextCubit(super.initialTitle);

  void updateTitle(String newTitle) => emit(newTitle);
}