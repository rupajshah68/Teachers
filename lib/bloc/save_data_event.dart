part of 'save_data_bloc.dart';

@immutable
abstract class SaveDataEvent {}

class SaveDataInitialEvent extends SaveDataEvent {}

class NameFieldFocusChanged extends SaveDataEvent {
  final bool focused;

  NameFieldFocusChanged({required this.focused});
}

class DobFieldFocusChanged extends SaveDataEvent {
  final bool focused;

  DobFieldFocusChanged({required this.focused});
}

class GenderFieldFocusChanged extends SaveDataEvent {
  final bool focused;

  GenderFieldFocusChanged({required this.focused});
}

class CalendarTapEvent extends SaveDataEvent {
  DateTime selDate;
  BuildContext context;
  CalendarTapEvent({required this.selDate, required this.context});
}

class SaveDataButtonClicked extends SaveDataEvent {
  final String name;
  final String dob;
  final String gender;
  final String tr_email;
  final bool validate;
  SaveDataButtonClicked(
      {required this.name,
      required this.dob,
      required this.gender,
      required this.tr_email,
      required this.validate});
}
