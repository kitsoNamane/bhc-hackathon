
import 'package:bhc_hackathon/view/navigation.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';
import 'package:bhc_hackathon/view_model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<ApplicationState>(context);
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
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                },
                )
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
                      p.router.push(
                        NavigationConstants.resetPasswordPath,
                      );
                  },
                  child: const Text("Forgot Password?")
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()) {
                      await p.signIn(_emailController.value.text.toLowerCase(), _passwordController.value.text);
                    }
                  },
                  child: const Text("Sign In"),
              ),
            ),
            Row(
              children: [
                const Text("Don't have an account?"),
                TextButton(onPressed: (){
                 p.router.push(
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
