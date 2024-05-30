part of 'update_dialog_show_bloc.dart';

@immutable
abstract class UpdateDialogShowState {}

class UpdateDialogShowInitial extends UpdateDialogShowState {}

class UpdateDialogShownState extends UpdateDialogShowState {
  String name;
  String dob;
  String gender;
  String id;
  UpdateDialogShownState(
      {required this.name,
      required this.dob,
      required this.gender,
      required this.id});
}

class NameFieldFocusState extends UpdateDialogShowState {
  bool hasFocus;
  NameFieldFocusState({required this.hasFocus});
}

class DobFieldFocusState extends UpdateDialogShowState {
  bool hasFocus;
  DobFieldFocusState({required this.hasFocus});
}

class CalendarShowState extends UpdateDialogShowState {
  DateTime? picked;
  CalendarShowState({required this.picked});
}

class UpdateDataSuccess extends UpdateDialogShowState {}
