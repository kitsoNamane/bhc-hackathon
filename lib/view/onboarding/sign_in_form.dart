
import 'package:bhc_hackathon/view/navigation.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a valid password";
                }
                return null;
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: (){
                      NavigationHelper.router.push(
                        NavigationConstants.resetPasswordPath,
                      );
                  },
                  child: const Text("Forgot Password?")
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()) {
                      NavigationHelper.router.go(
                        NavigationConstants.homePath,
                      );
                    }
                  },
                  child: const Text("Sign In"),
              ),
            ),
            Row(
              children: [
                const Text("Don't have an account?"),
                TextButton(onPressed: (){
                 NavigationHelper.router.push(
                   NavigationConstants.signUpPath,
                 );
                },child: const Text("Sign up here")),
              ],
            )
          ],
        ),
      ),

    );
  }
}
