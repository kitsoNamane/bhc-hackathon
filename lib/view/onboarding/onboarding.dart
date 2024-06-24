import 'package:bhc_hackathon/view/onboarding/customer_onboarding_form.dart';
import 'package:bhc_hackathon/view/onboarding/reset_password.dart';
import 'package:bhc_hackathon/view/onboarding/sign_in_form.dart';
import 'package:bhc_hackathon/view/onboarding/sign_up_form.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SignUpForm(),
      ),
    );
  }
}

class CustomerOnboarding extends StatelessWidget {
  const CustomerOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: OnboardingForm(),
      ),
    );
  }
}


class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: null,
        ),
        body: const Center(
          child: ResetPasswordForm(),
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
