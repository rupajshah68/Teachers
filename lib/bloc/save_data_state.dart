part of 'save_data_bloc.dart';

@immutable
abstract class SaveDataState {}

class SaveDataInitial extends SaveDataState {}

class NameFieldFocusState extends SaveDataState {
  bool hasFocus;
  NameFieldFocusState({required this.hasFocus});
}

class DobFieldFocusState extends SaveDataState {
  bool hasFocus;
  DobFieldFocusState({required this.hasFocus});
}

class GenderFieldFocusState extends SaveDataState {
  bool hasFocus;
  GenderFieldFocusState({required this.hasFocus});
}

class CalendarShowState extends SaveDataState {
  DateTime? picked;
  CalendarShowState({required this.picked});
}

class GenderNotFilled extends SaveDataState {}

class SaveDataSuccess extends SaveDataState {}

class SaveDataError extends SaveDataState {}
