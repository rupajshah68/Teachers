import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupInitialEvent>(signupInitialState);
    on<EmailFieldFocusChanged>(emailFieldFocusChangedState);
    on<PasswordFieldFocusChanged>(passwordFieldFocusChangedState);
    on<SignupButtonClicked>(signupButtonClickedState);
  }

  FutureOr<void> signupButtonClickedState(
      SignupButtonClicked event, Emitter<SignupState> emit) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(SignupSuccess(email: event.email));
    } catch (e) {
      emit(SignupFailure(error: e.toString()));
    }
  }

  FutureOr<void> signupInitialState(
      SignupInitialEvent event, Emitter<SignupState> emit) {
    emit(SignupInitial());
  }

  FutureOr<void> emailFieldFocusChangedState(
      EmailFieldFocusChanged event, Emitter<SignupState> emit) {
    emit(EmailFieldFocusState(hasFocus: event.focused));
  }

  FutureOr<void> passwordFieldFocusChangedState(
      PasswordFieldFocusChanged event, Emitter<SignupState> emit) {
    emit(PasswordFieldFocusState(hasFocus: event.focused));
  }
}
