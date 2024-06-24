import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/customer.dart';
import '../../view_model/app_state.dart';
import '../navigation_constants.dart';

class OnboardingForm extends StatefulWidget {
  const OnboardingForm({super.key});

  @override
  State<OnboardingForm> createState() => _OnboardingFormState();
}

class _OnboardingFormState extends State<OnboardingForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _plotNumberController = TextEditingController();

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
              controller: _firstnameController,
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
              controller: _lastnameController,
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
              controller: _phoneController,
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
              controller: _plotNumberController,
              enabled: _switched,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "BHC plot/house number",
              ),
              validator: (value) {
                if (value == null || value.isEmpty && _switched == true) {
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
                    p.onboarding(Customer(
                      uuid: p.currentUser?.uuid,
                      email: p.currentUser?.email,
                      firstname: _firstnameController.value.text,
                      lastname: _lastnameController.value.text,
                      phone: _phoneController.value.text,
                      photoUrl: _firstnameController.value.text,
                      bhcPlotNumber: _switched ?_plotNumberController.value.text : null,
                      isExistingCustomer: _switched,
                    ));
                  }
                },
                child: const Text("Complete Onboarding"),
              ),
            ),
          ],
        )
        ],
      ),
    );
  }
}
