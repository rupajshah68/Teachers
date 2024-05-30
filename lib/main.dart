import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers/bloc/home_bloc.dart';
import 'package:teachers/signin.dart';
import 'package:teachers/signup.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(const HomeWidget());
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final HomeBloc hb = HomeBloc();

  @override
  void initState() {
    hb.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocConsumer<HomeBloc, HomeState>(
          bloc: hb,
          listener: (context, state) {
            if (state is HomeNavigatetoSignupPageState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignupWidget()));
            } else if (state is HomeNavigatetoSigninPageState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SigninWidget()));
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.lightBlueAccent,
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: const Text(
                  "Teachers App",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 140.0,
                    child: ElevatedButton(
                      onPressed: () {
                        hb.add(HomeNavigatetoSignupPageEvent());
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.blue),
                        padding:
                            WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
                          (Set<WidgetState> states) {
                            return const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 30.0);
                          },
                        ),
                      ),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: 140.0,
                    child: ElevatedButton(
                      onPressed: () {
                        hb.add(HomeNavigatetoSigninPageEvent());
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.blue),
                        padding:
                            WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
                          (Set<WidgetState> states) {
                            return const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 30.0);
                          },
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                ],
              )),
            );
          }),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
