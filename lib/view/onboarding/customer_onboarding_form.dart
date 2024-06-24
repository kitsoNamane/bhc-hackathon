import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/app_state.dart';
import '../navigation_constants.dart';

class OnboardingForm extends StatefulWidget {
  const OnboardingForm({super.key});

  @override
  State<OnboardingForm> createState() => _OnboardingFormState();
}

class _OnboardingFormState extends State<OnboardingForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  var _switched = false;
  final WidgetStateProperty<Icon?> _thumbIcon =
  WidgetStateProperty.resolveWith<Icon?>(
        (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

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
                labelText: "Firstname",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Firstname required";
                }
                return null;
              },
            ),
            const SizedBox(width: double.infinity, height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Lastname",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lastname required";
                }
                return null;
              },
            ),
            const SizedBox(width: double.infinity, height: 16),
            TextFormField(
              controller: _repeatPasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Phone",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Phone required";
                }
                return null;
              },
            ),
            const SizedBox(width: double.infinity, height: 16),
            Row(children: [
              const Text("Already a BHC customer"),
              const SizedBox(width: 8),
              Switch(
                value: _switched,
                thumbIcon: _thumbIcon,
                onChanged: (bool value) {
                  setState(() {
                    _switched = value;
                  });
                }),
            ],),
            const SizedBox(width: double.infinity, height: 16),
            TextFormField(
              controller: _repeatPasswordController,
              enabled: _switched,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "BHC plot/house number",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "plot number required";
                }
                return null;
              },
            ),
            const SizedBox(width: double.infinity, height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()) {
                    await p.signUp(_emailController.value.text.toLowerCase(), _passwordController.value.text);
                  }
                },
                child: const Text("Sign Up"),
              ),
            ),
            Row(
              children: [
                const Text("Already have an account?"),
                TextButton(onPressed: (){
                  p.router.go(
                    NavigationConstants.signInPath,
                  );
                },child: const Text("Sign in here")),
              ],
            )
          ],
        )
        ],
      ),
    );
  }
}
