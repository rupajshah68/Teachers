part of 'signin_bloc.dart';

@immutable
abstract class SigninEvent {}

class SigninInitialEvent extends SigninEvent {}

class EmailFieldFocusChanged extends SigninEvent {
  final bool focused;

  EmailFieldFocusChanged({required this.focused});
}

class PasswordFieldFocusChanged extends SigninEvent {
  final bool focused;

  PasswordFieldFocusChanged({required this.focused});
}

class SigninButtonClicked extends SigninEvent {
  final String email;
  final String password;

  SigninButtonClicked({required this.email, required this.password});
}
