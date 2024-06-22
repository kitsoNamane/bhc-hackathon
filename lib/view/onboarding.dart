import 'package:flutter/material.dart';

import 'navigation.dart';

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
                CustomNavigationHelper.router.go(
                  CustomNavigationHelper.signInPath,
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
                CustomNavigationHelper.router.go(
                  CustomNavigationHelper.homePath,
                );
              },
              child: const Text('Go to home page'),
            ),
            ElevatedButton(
              onPressed: () {
                CustomNavigationHelper.router.push(
                  CustomNavigationHelper.signUpPath,
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
