import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

part 'save_data_event.dart';
part 'save_data_state.dart';

class SaveDataBloc extends Bloc<SaveDataEvent, SaveDataState> {
  SaveDataBloc() : super(SaveDataInitial()) {
    on<SaveDataInitialEvent>(saveDataInitialState);
    on<NameFieldFocusChanged>(nameFieldFocusChangedState);
    on<DobFieldFocusChanged>(dobFieldFocusChangedState);
    on<GenderFieldFocusChanged>(genderFieldFocusChangedState);
    on<CalendarTapEvent>(calendarShow);
    on<SaveDataButtonClicked>(saveDataState);
  }

  FutureOr<void> saveDataState(
      SaveDataButtonClicked event, Emitter<SaveDataState> emit) {
    if (event.gender.isEmpty) {
      emit(GenderNotFilled());
    } else if (event.validate) {
      CollectionReference cr =
          FirebaseFirestore.instance.collection('Students');
      cr.add({
        "name": event.name,
        "dob": event.dob,
        "gender": event.gender,
        "tr_email": event.tr_email
      });
      emit(SaveDataSuccess());
    } else {
      emit(SaveDataError());
    }
  }

  FutureOr<void> saveDataInitialState(
      SaveDataInitialEvent event, Emitter<SaveDataState> emit) {
    emit(SaveDataInitial());
  }

  FutureOr<void> nameFieldFocusChangedState(
      NameFieldFocusChanged event, Emitter<SaveDataState> emit) {
    emit(NameFieldFocusState(hasFocus: event.focused));
  }

  FutureOr<void> dobFieldFocusChangedState(
      DobFieldFocusChanged event, Emitter<SaveDataState> emit) {
    emit(DobFieldFocusState(hasFocus: event.focused));
  }

  FutureOr<void> genderFieldFocusChangedState(
      GenderFieldFocusChanged event, Emitter<SaveDataState> emit) {
    emit(GenderFieldFocusState(hasFocus: event.focused));
  }

  FutureOr<void> calendarShow(
      CalendarTapEvent event, Emitter<SaveDataState> emit) async {
    DateTime? picked = await showDatePicker(
      context: event.context,
      lastDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 43839)),
      initialDate: event.selDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    emit(CalendarShowState(picked: picked));
  }
}
