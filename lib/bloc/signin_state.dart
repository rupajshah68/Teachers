part of 'signin_bloc.dart';

@immutable
abstract class SigninState {}

class SigninInitial extends SigninState {}

class EmailFieldFocusState extends SigninState {
  bool hasFocus;
  EmailFieldFocusState({required this.hasFocus});
}

class PasswordFieldFocusState extends SigninState {
  bool hasFocus;
  PasswordFieldFocusState({required this.hasFocus});
}

class SigninSuccess extends SigninState {
  final String email;

  SigninSuccess({required this.email});
}

class SigninUnverified extends SigninState {
  final String email;

  SigninUnverified({required this.email});
}

class SigninFailure extends SigninState {
  final String error;

  SigninFailure({required this.error});
}
