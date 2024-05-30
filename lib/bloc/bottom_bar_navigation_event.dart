part of 'bottom_bar_navigation_bloc.dart';

@immutable
abstract class BottomBarNavigationEvent {}

class BottomBarNavigationNavigateEvent extends BottomBarNavigationEvent {
  int newIndex;
  BottomBarNavigationNavigateEvent(this.newIndex);
}
