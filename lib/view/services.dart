import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../view_model/app_state.dart';

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
  final _datePickerController = TextEditingController();
  final _faultDescriptionController = TextEditingController();
  final _plotNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _faultTypeController;
  String? _incidentController;
  var _isPlotNumberReadyOnly = true;
  var _isPhoneReadyOnly = true;
  var _isEmailReadyOnly = true;
  final _faultTypes = ["Electrical", "Carpentry", "Plumbing", "Masonry", "Mechanical", "External"];
  final _incidentsOptions = {
    "Electrical": ["geyser", "sockets", "lights", "distribution board"],
    "Carpentry": ["ceiling", "garage", "roof", "windows & frames"],
    "Plumbing": ["shower", "geyser leak", "pipes"],
    "Masonry": ["walls", "floors"],
    "Mechanical": ["air conditioner", "generator"],
    "External": ["sewage system", "water sypply", "water drainage"],
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Consumer<ApplicationState>(
            builder: (context, state, child) {
              _plotNumberController.text = state.currentUser?.bhcPlotNumber! ?? "";
              _phoneController.text = state.currentUser?.phone! ?? "";
              _emailController.text = state.currentUser?.email! ?? "";
              return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Report a fault",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
                const Divider(thickness: 4),
                const SizedBox(width: double.infinity, height: 28),
                TextFormField(
                  readOnly: _isPlotNumberReadyOnly,
                  controller: _plotNumberController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Plot/House Number",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.edit, size: 24),
                      onPressed: () {
                        setState(() {
                          _isPlotNumberReadyOnly = !_isPlotNumberReadyOnly;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter plot number";
                    }
                    return null;
                  },
                ),
                const SizedBox(width: double.infinity, height: 16),
                DropdownButtonFormField<String>(
                  value: _faultTypeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Type of fault",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a fault type";
                    }
                    return null;
                  }, items: _faultTypes
                    .map((label) => DropdownMenuItem(
                    value: label,
                    child: Text(label.toString()),
                  )).toList(),
                  onChanged: (Object? value) {
                    setState(() {
                      _faultTypeController = value.toString();
                      _incidentController = null;
                    });
                  },
                ),
                const SizedBox(width: double.infinity, height: 16),
                DropdownButtonFormField<String>(
                  value: _incidentController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Select Incident",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select incident";
                    }
                    return null;
                  }, items: _incidentsOptions[_faultTypeController]
                    ?.map((label) => DropdownMenuItem(
                  value: label,
                  child: Text(label.toString()),
                )).toList(),
                  onChanged: (Object? value) {
                    setState(() {
                      _incidentController = value.toString();
                    });
                  },
                ),
                const SizedBox(width: double.infinity, height: 16),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Fault Description",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        )
                    )
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
                const SizedBox(width: double.infinity, height: 24),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("How do we reach you?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        )
                    )
                ),
                const Divider(thickness: 2),
                Column(children: [
                  TextFormField(
                    readOnly: _isEmailReadyOnly,
                    controller: _emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border:  const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),),
                      labelText: "Email",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.edit, size: 24),
                        onPressed: () {
                          setState(() {
                            _isEmailReadyOnly = !_isEmailReadyOnly;
                          });
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
                    readOnly: _isPhoneReadyOnly,
                    controller: _phoneController,
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
                          setState(() {
                            _isPhoneReadyOnly = !_isPhoneReadyOnly;
                          });
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

                const SizedBox(width: double.infinity, height: 24),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Upload photo",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        )
                    )
                ),
                const Divider(thickness: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.camera_alt_outlined)),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.photo_library_outlined))
                ],),
                const SizedBox(width: double.infinity, height: 16),
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
            );},
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
      _datePickerController.text = f.format(selectedDate!);
    });
  }
}

