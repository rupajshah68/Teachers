part of 'email_bloc.dart';

@immutable
abstract class EmailState {}

class EmailInitial extends EmailState {}

class EmailSuccess extends EmailState {}

class EmailError extends EmailState {
  final String error;

  EmailError({required this.error});
}
