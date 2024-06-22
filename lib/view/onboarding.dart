import 'package:flutter/material.dart';

import 'navigation.dart';
import 'navigation_constants.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Onboarding screen"),
    );
  }
}

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignIn"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                NavigationHelper.router.go(
                  NavigationConstants.homePath,
                );
              },
              child: const Text('Go to home page'),
            ),
            ElevatedButton(
              onPressed: () {
                NavigationHelper.router.push(
                  NavigationConstants.signUpPath,
                );
              },
              child: const Text('Go to sign up page'),
            ),
          ],
        ),
      ),
    );
  }
}
