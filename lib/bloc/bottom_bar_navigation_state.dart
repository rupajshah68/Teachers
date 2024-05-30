part of 'bottom_bar_navigation_bloc.dart';

@immutable
abstract class BottomBarNavigationState {}

class BottomBarNavigationInitial extends BottomBarNavigationState {}

class BottomBarNavigateState extends BottomBarNavigationState {
  final int selIndex;
  BottomBarNavigateState({required this.selIndex});
}
