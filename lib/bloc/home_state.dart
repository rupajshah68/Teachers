part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}

class HomeNavigatetoSignupPageState extends HomeState {}

class HomeNavigatetoSigninPageState extends HomeState {}
