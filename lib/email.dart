import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers/bloc/email_bloc.dart';
import 'package:teachers/verifyemail.dart';

class EmailWidget extends StatefulWidget {
  late String email;
  EmailWidget({super.key, required this.email});
  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  bool isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
  final EmailBloc eb = EmailBloc();

  @override
  void initState() {
    super.initState();
    eb.add(SendEmailEvent(isVerified: isVerified));
  }

  Future sendEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailBloc, EmailState>(
      bloc: eb,
      listener: (context, state) {
        if (state is EmailError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return VerifyEmail(email: widget.email);
      },
    );
  }
}
