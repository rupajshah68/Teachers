import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

part 'update_dialog_show_event.dart';
part 'update_dialog_show_state.dart';

class UpdateDialogShowBloc
    extends Bloc<UpdateDialogShowEvent, UpdateDialogShowState> {
  UpdateDialogShowBloc() : super(UpdateDialogShowInitial()) {
    on<UpdateButtonClicked>(updateDialogShow);
    on<NameFieldFocusChanged>(nameFieldFocusChangedState);
    on<DobFieldFocusChanged>(dobFieldFocusChangedState);
    on<CalendarTapEvent>(calendarShowState);
    on<UpdateDataButtonClicked>(updateData);
  }

  FutureOr<void> updateDialogShow(
      UpdateButtonClicked event, Emitter<UpdateDialogShowState> emit) {
    emit(UpdateDialogShownState(
        name: event.name, dob: event.dob, gender: event.gender, id: event.id));
  }

  FutureOr<void> calendarShowState(
      CalendarTapEvent event, Emitter<UpdateDialogShowState> emit) async {
    DateTime? picked = await showDatePicker(
      context: event.context,
      lastDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 43839)),
      initialDate: event.selDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    emit(CalendarShowState(picked: picked));
  }

  FutureOr<void> updateData(
      UpdateDataButtonClicked event, Emitter<UpdateDialogShowState> emit) {
    CollectionReference cr = FirebaseFirestore.instance.collection('Students');
    cr.doc(event.id).update({
      "name": event.name,
      "dob": event.dob,
      "gender": event.gender,
    });
    emit(UpdateDataSuccess());
  }

  FutureOr<void> nameFieldFocusChangedState(
      NameFieldFocusChanged event, Emitter<UpdateDialogShowState> emit) {
    emit(NameFieldFocusState(hasFocus: event.focused));
  }

  FutureOr<void> dobFieldFocusChangedState(
      DobFieldFocusChanged event, Emitter<UpdateDialogShowState> emit) {
    emit(DobFieldFocusState(hasFocus: event.focused));
  }
}
