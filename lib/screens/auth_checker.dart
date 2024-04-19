import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wegro/screens/home_page.dart';
import 'package:wegro/screens/sign_up_page.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is already authenticated, navigate to home page
      return HomePage();
    } else {
      // User is not authenticated, navigate to sign up/login page
      return SignUpPage();
    }
  }
}
