
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
  
  final ValueNotifier<bool> _isFormSubmitting = ValueNotifier(false);
  final ValueNotifier<bool> _showErrorMessage = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<ApplicationState>(context);
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 256),
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
                valueListenable: _isFormSubmitting, builder: (context, value, child) =>
            _isFormSubmitting.value ?
            const CircularProgressIndicator()
                : const SizedBox(width: 0, height: 0)),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: () async {
                    _isFormSubmitting.value = true;
                    _showErrorMessage.value = false;
                    if(_formKey.currentState!.validate()) {
                      await p.signIn(_emailController.value.text.toLowerCase(), _passwordController.value.text);
                      _showErrorMessage.value = p.currentUser == null;
                    }
                    _isFormSubmitting.value = false;
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
        )],
      ),
    );
  }
}
