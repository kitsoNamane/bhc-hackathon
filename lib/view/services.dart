import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FaultForm(),
      ),
    );
  }
}

class FaultForm extends StatefulWidget {
  const FaultForm({super.key});

  @override
  State<FaultForm> createState() => _FaultFormState();
}

class _FaultFormState extends State<FaultForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _datePickerController = TextEditingController();
  final _faultDescriptionController = TextEditingController();

  bool _passwordVisible = true;
  bool _repeatPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
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
                obscureText: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Type of fault",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_drop_down, size: 36),
                    onPressed: () {
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select a fault type";
                  }
                  return null;
                },
              ),
              const SizedBox(width: double.infinity, height: 16),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Fault Description")
              ),
              TextFormField(
                controller: _faultDescriptionController,
                obscureText: false,
                minLines: 4,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Description required";
                  }
                  return null;
                },
              ),
              const SizedBox(width: double.infinity, height: 16),
              TextFormField(
                readOnly: true,
                onTap: () {
                  _showDatePicker(context);
                },
                controller: _datePickerController,
                obscureText: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Enter date when fault occurred",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.date_range_outlined),
                    onPressed: () {
                      _showDatePicker(context);
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid date";
                  }
                  return null;
                },
              ),
              const SizedBox(width: double.infinity, height: 16),
              const Divider(thickness: 2),
              const SizedBox(width: double.infinity, height: 8),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("What's your preferred communication details")
              ),
              Column(children: [
                TextFormField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    labelText: "Email",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.edit, size: 24),
                      onPressed: () {
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email required";
                    }
                    return null;
                  },
                ),
                const SizedBox(width: double.infinity, height: 8),
                TextFormField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    labelText: "Phone",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.edit, size: 24),
                      onPressed: () {
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone required";
                    }
                    return null;
                  },
                ),
              ],),

              const SizedBox(width: double.infinity, height: 16),
              const Divider(thickness: 2),
              const SizedBox(width: double.infinity, height: 8),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Upload photo")
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.camera_alt_outlined)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.photo_library_outlined))
              ],),
              const SizedBox(width: double.infinity, height: 16),
              const Divider(thickness: 2),
              const Text("You'll receive a reference number after submission"),
              const SizedBox(width: double.infinity, height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()) {
                    }
                  },
                  child: const Text("Send Fault Ticket"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
        context: context,
        firstDate: DateTime.now().subtract(const Duration(hours: 730)),
        lastDate: DateTime.now(),
    ).then((selectedDate) {
      var f = DateFormat("dd/MM/yyyy");
      _datePickerController.text = f.format(selectedDate!!);
    });
  }
}

