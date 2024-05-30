import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'sign_out_event.dart';
part 'sign_out_state.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  SignOutBloc() : super(SignOutInitial()) {
    on<SignOutButtonClicked>(signOutButtonClicked);
  }

  FutureOr<void> signOutButtonClicked(
      SignOutButtonClicked event, Emitter<SignOutState> emit) async {
    await FirebaseAuth.instance.signOut();
    emit(SignOutSuccess());
  }
}
