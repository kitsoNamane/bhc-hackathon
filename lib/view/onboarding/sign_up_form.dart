
import 'package:bhc_hackathon/view/navigation.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/app_state.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  bool _passwordVisible = true;
  bool _repeatPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    final router = Provider.of<ApplicationState>(context).router;
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a valid email";
                }
                return null;
              },
            ),
            const SizedBox(width: double.infinity, height: 16),
            TextFormField(
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Phone",
              ),
            ),
            const SizedBox(width: double.infinity, height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off
                  ), onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                )
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a valid password";
                } else if (value.isNotEmpty && value.toLowerCase() != _repeatPasswordController.value.text.toLowerCase()) {
                return "Passwords should match";
                }
                return null;
              },
            ),
            const SizedBox(width: double.infinity, height: 16),
            TextFormField(
              controller: _repeatPasswordController,
              obscureText: _repeatPasswordVisible,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Repeat password",
                suffixIcon: IconButton(
                  icon: Icon(_repeatPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off
                  ), onPressed: () {
                    setState(() {
                      _repeatPasswordVisible = !_repeatPasswordVisible;
                    });
                },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a valid password";
                } else if (value.isNotEmpty && value.toLowerCase() != _passwordController.value.text.toLowerCase()) {
                  return "Passwords should match";
                }
                return null;
              },
            ),
            const SizedBox(width: double.infinity, height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()) {
                    router.go(
                      NavigationConstants.homePath,
                    );
                  }
                },
                child: const Text("Sign Up"),
              ),
            ),
            Row(
              children: [
                const Text("Already have an account?"),
                TextButton(onPressed: (){
                  router.go(
                    NavigationConstants.signInPath,
                  );
                },child: const Text("Sign in here")),
              ],
            )
          ],
        ),
      ),

    );
  }
}
