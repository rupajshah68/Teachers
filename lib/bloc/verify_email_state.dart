part of 'verify_email_bloc.dart';

@immutable
abstract class VerifyEmailState {}

class VerifyEmailInitial extends VerifyEmailState {}

class EmailVerified extends VerifyEmailState {}

class EmailNotVerified extends VerifyEmailState {}
