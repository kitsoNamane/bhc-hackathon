import 'package:bhc_hackathon/view/onboarding/sign_in_form.dart';
import 'package:flutter/material.dart';

import '../navigation.dart';
import '../navigation_constants.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp"),
      ),
      body: Center(
            child: ElevatedButton(
              onPressed: () {
                NavigationHelper.router.go(
                  NavigationConstants.signInPath,
                );
              },
              child: const Text('Go to Sign In'),
            ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SignInForm()
        ),
    );
  }
}
