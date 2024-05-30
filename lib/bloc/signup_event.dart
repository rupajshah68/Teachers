part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class SignupInitialEvent extends SignupEvent {}

class EmailFieldFocusChanged extends SignupEvent {
  final bool focused;

  EmailFieldFocusChanged({required this.focused});
}

class PasswordFieldFocusChanged extends SignupEvent {
  final bool focused;

  PasswordFieldFocusChanged({required this.focused});
}

class SignupButtonClicked extends SignupEvent {
  final String email;
  final String password;

  SignupButtonClicked({required this.email, required this.password});
}
