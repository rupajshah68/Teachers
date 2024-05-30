import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers/bloc/signin_bloc.dart';
import 'package:teachers/teachers.dart';
import 'package:teachers/verifyemail.dart';

class SigninWidget extends StatefulWidget {
  const SigninWidget({super.key});

  @override
  State<SigninWidget> createState() => _SigninWidgetState();
}

class _SigninWidgetState extends State<SigninWidget> {
  User? user;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailCont = TextEditingController();
  TextEditingController pwdcont = TextEditingController();
  FocusNode femail = FocusNode();
  FocusNode fpwd = FocusNode();
  final SigninBloc sb = SigninBloc();

  @override
  void initState() {
    sb.add(SigninInitialEvent());
    sb.add(EmailFieldFocusChanged(focused: femail.hasFocus));
    sb.add(PasswordFieldFocusChanged(focused: fpwd.hasFocus));
    femail.addListener(() {
      sb.add(EmailFieldFocusChanged(focused: femail.hasFocus));
    });
    fpwd.addListener(() {
      sb.add(PasswordFieldFocusChanged(focused: fpwd.hasFocus));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocConsumer<SigninBloc, SigninState>(
        bloc: sb,
        listener: (context, state) {
          if (state is SigninSuccess) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Teachers(email: state.email)));
          } else if (state is SigninUnverified) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VerifyEmail(
                      email: state.email,
                    )));
          } else if (state is SigninFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
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
              ),
              backgroundColor: Colors.lightBlueAccent,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          cursorColor: Colors.purple,
                          focusNode: femail,
                          decoration: InputDecoration(
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              labelText: "Email ID",
                              labelStyle: TextStyle(
                                  color: (femail.hasFocus
                                      ? Colors.purple
                                      : Colors.white)),
                              hintText: "Your email ID",
                              hintStyle: const TextStyle(color: Colors.white),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.purple))),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null) {
                              return "Email ID is required.";
                            } else if (value.isEmpty) {
                              return "Email ID is required.";
                            } else if (!RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                .hasMatch(value)) {
                              return 'Email ID is not valid.';
                            }
                            return null;
                          },
                          controller: emailCont,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          cursorColor: Colors.purple,
                          focusNode: fpwd,
                          obscureText: true,
                          decoration: InputDecoration(
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  color: (fpwd.hasFocus
                                      ? Colors.purple
                                      : Colors.white)),
                              hintText: "Password",
                              hintStyle: const TextStyle(color: Colors.white),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.purple))),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null) {
                              return "Password is required.";
                            } else if (value.isEmpty) {
                              return "Password is required.";
                            }
                            return null;
                          },
                          controller: pwdcont,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                sb.add(SigninButtonClicked(
                                    email: emailCont.text,
                                    password: pwdcont.text));
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.blue),
                              padding: WidgetStateProperty.resolveWith<
                                  EdgeInsetsGeometry>(
                                (Set<WidgetState> states) {
                                  return const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 30.0);
                                },
                              ),
                            ),
                            child: const Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
