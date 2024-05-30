part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class EmailFieldFocusState extends SignupState {
  bool hasFocus;
  EmailFieldFocusState({required this.hasFocus});
}

class PasswordFieldFocusState extends SignupState {
  bool hasFocus;
  PasswordFieldFocusState({required this.hasFocus});
}

class SignupSuccess extends SignupState {
  final String email;

  SignupSuccess({required this.email});
}

class SignupFailure extends SignupState {
  final String error;

  SignupFailure({required this.error});
}
