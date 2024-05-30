import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers/bloc/bottom_bar_navigation_bloc.dart';
import 'package:teachers/bloc/sign_out_bloc.dart';
import 'package:teachers/savedataform.dart';
import 'package:teachers/signin.dart';
import 'package:teachers/viewdata.dart';

class Teachers extends StatefulWidget {
  String email;
  Teachers({super.key, required this.email});

  @override
  State<Teachers> createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  final SignOutBloc sb = SignOutBloc();
  final BottomBarNavigationBloc nb = BottomBarNavigationBloc();

  @override
  void initState() {
    nb.add(BottomBarNavigationNavigateEvent(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MultiBlocListener(
        listeners: [
          BlocListener<SignOutBloc, SignOutState>(
              bloc: sb,
              listener: (context, state) {
                if (state is SignOutSuccess) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SigninWidget()));
                }
              }),
        ],
        child: BlocBuilder<BottomBarNavigationBloc, BottomBarNavigationState>(
          bloc: nb,
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: const Text(
                  "Teachers App",
                  style: TextStyle(color: Colors.white),
                ),
                leading: const BackButton(
                  color: Colors.white,
                ),
                actions: <Widget>[
                  IconButton(
                      onPressed: () {
                        sb.add(SignOutButtonClicked());
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      )),
                ],
              ),
              body: [
                SaveDataForm(email: widget.email),
                ViewData(email: widget.email),
              ][(state is BottomBarNavigateState ? state.selIndex : 0)],
              backgroundColor: Colors.lightBlueAccent,
              bottomNavigationBar: NavigationBarTheme(
                data: NavigationBarThemeData(
                  labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                    (Set<WidgetState> states) =>
                        states.contains(WidgetState.selected)
                            ? const TextStyle(color: Colors.purple)
                            : const TextStyle(color: Colors.white),
                  ),
                ),
                child: NavigationBar(
                    backgroundColor: Colors.blue,
                    indicatorColor: Colors.purple,
                    selectedIndex:
                        state is BottomBarNavigateState ? state.selIndex : 0,
                    onDestinationSelected: (int index) {
                      nb.add(BottomBarNavigationNavigateEvent(index));
                    },
                    destinations: const <NavigationDestination>[
                      NavigationDestination(
                          icon: Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          label: "Store students' data"),
                      NavigationDestination(
                          icon: Icon(
                            Icons.visibility,
                            color: Colors.white,
                          ),
                          label: "See/Update data")
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
