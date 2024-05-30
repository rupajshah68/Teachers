import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'email_event.dart';
part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc() : super(EmailInitial()) {
    on<SendEmailEvent>(sendEmailState);
  }

  FutureOr<void> sendEmailState(
      SendEmailEvent event, Emitter<EmailState> emit) async {
    if (!event.isVerified) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        await user!.sendEmailVerification();
        emit(EmailSuccess());
      } catch (e) {
        emit(EmailError(error: e.toString()));
      }
    }
  }
}
