import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers/bloc/update_dialog_show_bloc.dart';

class UpdateData extends StatefulWidget {
  String name;
  String dob;
  String gender;
  String id;
  UpdateData(
      {super.key,
      required this.name,
      required this.dob,
      required this.gender,
      required this.id});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController dob;
  late TextEditingController gender;
  DateTime? selDate;
  FocusNode fname = FocusNode();
  FocusNode fdob = FocusNode();
  final UpdateDialogShowBloc ub = UpdateDialogShowBloc();

  @override
  void initState() {
    name = TextEditingController(text: widget.name);
    dob = TextEditingController(text: widget.dob);
    gender = TextEditingController(text: widget.gender);
    selDate = DateTime.parse(widget.dob);
    ub.add(NameFieldFocusChanged(focused: fname.hasFocus));
    ub.add(DobFieldFocusChanged(focused: fdob.hasFocus));
    fname.addListener(() {
      ub.add(NameFieldFocusChanged(focused: fname.hasFocus));
    });
    fdob.addListener(() {
      ub.add(DobFieldFocusChanged(focused: fname.hasFocus));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateDialogShowBloc, UpdateDialogShowState>(
      bloc: ub,
      listener: (context, state) {
        if (state is CalendarShowState) {
          if (state.picked != null) {
            selDate = state.picked;
            dob.text = state.picked.toString().split(" ")[0];
          }
        } else if (state is UpdateDataSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Data is successfully updated.")));
        }
      },
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    focusNode: fname,
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        labelText: "Name of student",
                        hintText: "Name of student",
                        hintStyle: const TextStyle(color: Colors.white),
                        labelStyle: TextStyle(
                            color: (fname.hasFocus
                                ? Colors.purple
                                : Colors.white)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple))),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null) {
                        return "Name of student is required.";
                      } else if (value.isEmpty) {
                        return "Name of student is required.";
                      } else if (!RegExp(r'([A-Z]{2,})|([A-Z][a-z]+)')
                          .hasMatch(value)) {
                        return "Name of student is not proper.";
                      }
                      return null;
                    },
                    controller: name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      focusNode: fdob,
                      cursorColor: Colors.purple,
                      controller: dob,
                      decoration: InputDecoration(
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          labelText: 'Date of Birth',
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple)),
                          labelStyle: TextStyle(
                              color: (fdob.hasFocus
                                  ? Colors.purple
                                  : Colors.white)),
                          prefixIcon: const Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                          )),
                      readOnly: true,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null) {
                          return "Date of Birth is required.";
                        } else if (value.isEmpty) {
                          return "Date of Birth is required.";
                        }
                        return null;
                      },
                      onTap: () {
                        ub.add(CalendarTapEvent(
                            selDate: selDate!, context: context));
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownMenu(
                    enableFilter: false,
                    enableSearch: false,
                    requestFocusOnTap: false,
                    textStyle: const TextStyle(color: Colors.white),
                    menuStyle: const MenuStyle(
                      backgroundColor:
                          WidgetStatePropertyAll<Color>(Colors.blue),
                    ),
                    controller: gender,
                    dropdownMenuEntries: const <DropdownMenuEntry>[
                      DropdownMenuEntry(
                          value: "Male",
                          label: "Male",
                          style: ButtonStyle(
                              foregroundColor:
                                  WidgetStatePropertyAll(Colors.white))),
                      DropdownMenuEntry(
                          value: "Female",
                          label: "Female",
                          style: ButtonStyle(
                              foregroundColor:
                                  WidgetStatePropertyAll(Colors.white))),
                      DropdownMenuEntry(
                          value: "Third Gender",
                          label: "Third Gender",
                          style: ButtonStyle(
                              foregroundColor:
                                  WidgetStatePropertyAll(Colors.white)))
                    ],
                    label: const Text("Gender"),
                    inputDecorationTheme: const InputDecorationTheme(
                        suffixIconColor: Colors.white,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                        labelStyle: TextStyle(color: (Colors.white))),
                    expandedInsets: EdgeInsets.zero,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ub.add(UpdateDataButtonClicked(
                            name: name.text,
                            dob: dob.text,
                            gender: gender.text,
                            id: widget.id));
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.purple),
                      padding:
                          WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
                        (Set<WidgetState> states) {
                          return const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 30.0);
                        },
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Update data",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
