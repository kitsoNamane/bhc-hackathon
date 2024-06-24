
import 'package:bhc_hackathon/view/navigation_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/app_state.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => ResetPasswordFormState();
}

class ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
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
            const TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email Or Phone",
              ),
            ),
            const SizedBox(width: double.infinity, height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: (){
                },
                child: const Text("Reset Password"),
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
