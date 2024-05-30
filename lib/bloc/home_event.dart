part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeNavigatetoSignupPageEvent extends HomeEvent {}

class HomeNavigatetoSigninPageEvent extends HomeEvent {}
