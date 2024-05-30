import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers/bloc/save_data_bloc.dart';

class SaveDataForm extends StatefulWidget {
  late String email;
  SaveDataForm({super.key, required this.email});

  @override
  State<SaveDataForm> createState() => _SaveDataFormState();
}

class _SaveDataFormState extends State<SaveDataForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController gender = TextEditingController();
  DateTime? selDate = DateTime.now();
  FocusNode fname = FocusNode();
  FocusNode fdob = FocusNode();
  String? generr;
  final SaveDataBloc sdb = SaveDataBloc();

  @override
  void initState() {
    sdb.add(SaveDataInitialEvent());
    sdb.add(NameFieldFocusChanged(focused: fname.hasFocus));
    sdb.add(DobFieldFocusChanged(focused: fdob.hasFocus));
    fname.addListener(() {
      sdb.add(NameFieldFocusChanged(focused: fname.hasFocus));
    });
    fdob.addListener(() {
      sdb.add(DobFieldFocusChanged(focused: fname.hasFocus));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocConsumer<SaveDataBloc, SaveDataState>(
        bloc: sdb,
        listener: (context, state) {
          if (state is SaveDataSuccess) {
            name.text = "";
            dob.text = "";
            gender.text = "";
            generr = null;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Data is successfully stored.")));
          } else if (state is GenderNotFilled) {
            generr = "Gender is required.";
          } else if (state is SaveDataError) {
            generr = null;
          }
          if (state is CalendarShowState) {
            if (state.picked != null) {
              selDate = state.picked;
              dob.text = state.picked.toString().split(" ")[0];
            }
          }
        },
        builder: (ctx, state) {
          return Scaffold(
            backgroundColor: Colors.lightBlueAccent,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                            sdb.add(CalendarTapEvent(
                                selDate: selDate!, context: ctx));
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownMenu(
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
                        errorText: generr,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            sdb.add(SaveDataButtonClicked(
                                name: name.text,
                                dob: dob.text,
                                gender: gender.text,
                                tr_email: widget.email,
                                validate: true));
                          } else {
                            sdb.add(SaveDataButtonClicked(
                                name: name.text,
                                dob: dob.text,
                                gender: gender.text,
                                tr_email: widget.email,
                                validate: false));
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.blue),
                          padding: WidgetStateProperty.resolveWith<
                              EdgeInsetsGeometry>(
                            (Set<WidgetState> states) {
                              return const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 30.0);
                            },
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Store data",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
