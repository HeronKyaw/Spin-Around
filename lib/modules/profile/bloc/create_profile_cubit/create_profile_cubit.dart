import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'create_profile_state.dart';

class CreateProfileCubit extends Cubit<CreateProfileState> {
  CreateProfileCubit() : super(CreateProfileInitial());
}
