import 'package:project/screens/Authentication/auth.dart';
import 'package:project/screens/Authentication/home_page.dart';
import 'package:project/screens/Authentication/login_register_page.dart';
import 'package:project/screens/Authentication/email_verification_page.dart'; // <-- Create and import this
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.emailVerified) {
          return HomePage();
        } else if (snapshot.hasData && !snapshot.data!.emailVerified) {
          return const EmailVerificationPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
