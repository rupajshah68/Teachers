import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers/bloc/verify_email_bloc.dart';
import 'package:teachers/teachers.dart';

class VerifyEmail extends StatefulWidget {
  late String email;
  VerifyEmail({super.key, required this.email});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isVerified = false;
  late Timer timer;
  final VerifyEmailBloc veb = VerifyEmailBloc();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      veb.add(CheckEmailVerificatonStatus());
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocConsumer<VerifyEmailBloc, VerifyEmailState>(
        bloc: veb,
        listener: (context, state) {
          if (state is EmailVerified) {
            timer.cancel();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Teachers(
                      email: widget.email,
                    )));
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
            body: const Center(
              child: Text(
                "Kindly verify your email.",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          );
        },
      ),
    );
  }
}
