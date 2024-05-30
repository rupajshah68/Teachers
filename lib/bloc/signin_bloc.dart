import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitial()) {
    on<SigninInitialEvent>(signinInitialState);
    on<EmailFieldFocusChanged>(emailFieldFocusChangedState);
    on<PasswordFieldFocusChanged>(passwordFieldFocusChangedState);
    on<SigninButtonClicked>(signupButtonClickedState);
  }

  FutureOr<void> signupButtonClickedState(
      SigninButtonClicked event, Emitter<SigninState> emit) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      User user = FirebaseAuth.instance.currentUser!;
      if (user.emailVerified) {
        emit(SigninSuccess(email: event.email));
      } else {
        emit(SigninUnverified(email: event.email));
      }
    } catch (e) {
      emit(SigninFailure(error: e.toString()));
    }
  }

  FutureOr<void> signinInitialState(
      SigninInitialEvent event, Emitter<SigninState> emit) {
    emit(SigninInitial());
  }

  FutureOr<void> emailFieldFocusChangedState(
      EmailFieldFocusChanged event, Emitter<SigninState> emit) {
    emit(EmailFieldFocusState(hasFocus: event.focused));
  }

  FutureOr<void> passwordFieldFocusChangedState(
      PasswordFieldFocusChanged event, Emitter<SigninState> emit) {
    emit(PasswordFieldFocusState(hasFocus: event.focused));
  }
}
