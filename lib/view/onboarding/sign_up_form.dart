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

  final ValueNotifier<bool> _isFormSubmitting = ValueNotifier(false);
  final ValueNotifier<bool> _showErrorMessage = ValueNotifier(false);
  bool _passwordVisible = true;
  bool _repeatPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<ApplicationState>(context);
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 128),
          Column(
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
                controller: _passwordController,
                obscureText: _passwordVisible,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid password";
                  } else if (value.isNotEmpty &&
                      value.toLowerCase() !=
                          _repeatPasswordController.value.text.toLowerCase()) {
                    return "Passwords should match";
                  } else if (value.isNotEmpty && value.length < 6) {
                    return "Password should be at least 6 characters";
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
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _repeatPasswordVisible = !_repeatPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid password";
                  } else if (value.isNotEmpty &&
                      value.toLowerCase() !=
                          _passwordController.value.text.toLowerCase()) {
                    return "Passwords should match";
                  } else if (value.isNotEmpty && value.length < 6) {
                    return "Password should be at least 6 characters";
                  }
                  return null;
                },
              ),
              ValueListenableBuilder(
                  valueListenable: _showErrorMessage,
                  builder: (context, value, child) => _showErrorMessage.value
                      ? Align(
                        alignment: Alignment.topLeft,
                        child: Text("Error occurred please try again",
                            style: TextStyle(
                              color: Colors.red[900],
                            ),
                        ),
                      )
                      : const SizedBox(width: 0, height: 0)),
              ValueListenableBuilder(
                  valueListenable: _isFormSubmitting,
                  builder: (context, value, child) => _isFormSubmitting.value
                      ? const CircularProgressIndicator()
                      : const SizedBox(width: 0, height: 0)),
              const SizedBox(width: double.infinity, height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    _showErrorMessage.value = false;
                    _isFormSubmitting.value = true;
                    if (_formKey.currentState!.validate()) {
                      await p.signUp(_emailController.value.text.toLowerCase(),
                          _passwordController.value.text);
                      _showErrorMessage.value = p.currentUser == null;
                    }
                    _isFormSubmitting.value = false;
                  },
                  child: const Text("Sign Up"),
                ),
              ),
              Row(
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        p.router.go(
                          NavigationConstants.signInPath,
                        );
                      },
                      child: const Text("Sign in here")),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
