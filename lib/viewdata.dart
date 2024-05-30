import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers/bloc/update_dialog_show_bloc.dart';
import 'package:teachers/updatedialog.dart';

class ViewData extends StatefulWidget {
  late String email;
  ViewData({super.key, required this.email});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  final UpdateDialogShowBloc ub = UpdateDialogShowBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateDialogShowBloc, UpdateDialogShowState>(
      bloc: ub,
      listener: (context, state) {
        if (state is UpdateDialogShownState) {
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return UpdateData(
                    name: state.name,
                    dob: state.dob,
                    gender: state.gender,
                    id: state.id);
              });
        }
      },
      builder: (context, state) {
        return Material(
          child: Scaffold(
            backgroundColor: Colors.lightBlueAccent,
            body: SafeArea(
                child: InteractiveViewer(
              constrained: false,
              boundaryMargin:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Students')
                    .snapshots(),
                builder: (context, snapshot) {
                  List<DataRow> sws = [];
                  if (snapshot.hasData) {
                    final students = snapshot.data?.docs.toList();
                    for (var student in students!) {
                      if (student['tr_email'] == widget.email) {
                        final sw = DataRow(
                          cells: [
                            DataCell(Text(
                              student['name'],
                              style: const TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              student['dob'],
                              style: const TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              student['gender'],
                              style: const TextStyle(color: Colors.white),
                            )),
                            DataCell(Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.blue),
                                ),
                                onPressed: () {
                                  ub.add(UpdateButtonClicked(
                                      name: student['name'],
                                      dob: student['dob'],
                                      gender: student['gender'],
                                      id: student.id));
                                },
                                child: const Text(
                                  "Update",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ))
                          ],
                        );
                        sws.add(sw);
                      }
                    }
                  }
                  return DataTable(
                    columns: const [
                      DataColumn(
                          label: Text(
                        "Name of student",
                        style: TextStyle(color: Colors.white),
                      )),
                      DataColumn(
                          label: Text(
                        "Date of Birth",
                        style: TextStyle(color: Colors.white),
                      )),
                      DataColumn(
                          label: Text(
                        "Gender",
                        style: TextStyle(color: Colors.white),
                      )),
                      DataColumn(label: Text(""))
                    ],
                    rows: sws,
                  );
                },
              ),
            )),
          ),
        );
      },
    );
  }
}
