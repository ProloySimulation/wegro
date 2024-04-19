import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wegro/providers/signup_provider.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _signUpWithGoogle(BuildContext context) async {
    final signupProvider = Provider.of<SignupProvider>(context, listen: false);
    await signupProvider.signUpWithGoogle(context);
  }

  void _signUpWithEmailAndPassword(BuildContext context, String email, String password) async {
    final signupProvider = Provider.of<SignupProvider>(context, listen: false);

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill up email & password.'),
        ),
      );
      return;
    } else if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password must be at least six characters.'),
        ),
      );
      return;
    }

    await signupProvider.signInWithEmailAndPassword(context, email, password);
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();
                _signUpWithEmailAndPassword(context, email, password);
              },
              child: Text('Sign In'),
            ),
            SizedBox(height: 20),
            TextButton.icon(
              onPressed: () => _signUpWithGoogle(context),
              icon: Image.asset('assets/images/ic_google.png', width: 24, height: 24),
              label: Text('Sign In with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
