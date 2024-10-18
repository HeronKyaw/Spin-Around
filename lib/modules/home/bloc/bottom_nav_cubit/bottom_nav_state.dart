part of 'bottom_nav_cubit.dart';

sealed class BottomNavState extends Equatable {
  const BottomNavState();
  @override
  List<Object> get props => [];
}

class HomeTab extends BottomNavState {}

class SettingTab extends BottomNavState {}
