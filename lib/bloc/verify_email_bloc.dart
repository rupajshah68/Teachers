import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'verify_email_event.dart';
part 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  VerifyEmailBloc() : super(VerifyEmailInitial()) {
    on<CheckEmailVerificatonStatus>(checkStatusState);
  }

  FutureOr<void> checkStatusState(
      CheckEmailVerificatonStatus event, Emitter<VerifyEmailState> emit) async {
    await FirebaseAuth.instance.currentUser!.reload();
    final isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (isVerified) {
      emit(EmailVerified());
    } else {
      emit(EmailNotVerified());
    }
  }
}
