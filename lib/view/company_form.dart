import 'package:flutter/material.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';
import 'package:provider/provider.dart';

import '../view_model/app_state.dart';

class CompanyHouseForm extends StatefulWidget {
  const CompanyHouseForm({super.key});

  @override
  State<CompanyHouseForm> createState() => _CompanyHouseFormState();
}

class _CompanyHouseFormState extends State<CompanyHouseForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('House Application (Company)'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<ApplicationState>(context, listen: false).router.push(NavigationConstants.homePath);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fill in the following details to apply for a house',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(thickness: 4),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Type of application',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Rent', child: Text('Rent')),
                    DropdownMenuItem(value: 'Buy', child: Text('Buy')),
                  ],
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the type of application';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildUploadField('Upload copy of company registration'),
                const SizedBox(height: 16),
                _buildUploadField('Upload copy of certificate of shares'),
                const SizedBox(height: 16),
                _buildUploadField('Company resolution on renting BHC property'),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process form submission logic here
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadField(String label) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          const Icon(Icons.upload),
        ],
      ),
    );
  }
}
