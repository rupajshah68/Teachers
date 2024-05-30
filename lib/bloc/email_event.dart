part of 'email_bloc.dart';

@immutable
abstract class EmailEvent {}

class EmailInitialEvent extends EmailEvent {}

class SendEmailEvent extends EmailEvent {
  bool isVerified;
  SendEmailEvent({required this.isVerified});
}
