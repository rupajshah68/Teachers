part of 'update_dialog_show_bloc.dart';

@immutable
abstract class UpdateDialogShowEvent {}

class UpdateButtonClicked extends UpdateDialogShowEvent {
  String name;
  String dob;
  String gender;
  String id;
  UpdateButtonClicked(
      {required this.name,
      required this.dob,
      required this.gender,
      required this.id});
}

class NameFieldFocusChanged extends UpdateDialogShowEvent {
  final bool focused;

  NameFieldFocusChanged({required this.focused});
}

class DobFieldFocusChanged extends UpdateDialogShowEvent {
  final bool focused;

  DobFieldFocusChanged({required this.focused});
}

class CalendarTapEvent extends UpdateDialogShowEvent {
  DateTime selDate;
  BuildContext context;
  CalendarTapEvent({required this.selDate, required this.context});
}

class UpdateDataButtonClicked extends UpdateDialogShowEvent {
  String name;
  String dob;
  String gender;
  String id;
  UpdateDataButtonClicked({
    required this.name,
    required this.dob,
    required this.gender,
    required this.id,
  });
}
