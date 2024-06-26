import 'package:flutter/material.dart';
import 'package:bhc_hackathon/view/navigation.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';

class IndividualHouseForm extends StatefulWidget {
  const IndividualHouseForm({super.key});

  @override
  State<IndividualHouseForm> createState() => IndividualHouseFormState();
}

class IndividualHouseFormState extends State<IndividualHouseForm> {
  final _formKey = GlobalKey<FormState>();

  // Define TextEditingController for each text field
  final TextEditingController _propertyIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('House Application (Individual)'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
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
                  decoration: InputDecoration(
                    labelText: 'Type of application',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
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
                TextFormField(
                  controller: _propertyIDController,
                  decoration: InputDecoration(
                    labelText: 'Property ID',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.edit),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Property ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildUploadField('Upload copy of identity documents'),
                const SizedBox(height: 16),
                _buildUploadField('Upload ITC clearance document'),
                const SizedBox(height: 16),
                const Text(
                  'If married provide the following',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildUploadField('Upload copy of marriage certificate'),
                const SizedBox(height: 16),
                _buildUploadField('Upload consent letter from spouse'),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      NavigationHelper.router.push(
                        NavigationConstants.companyHousePath,
                      );
                    },
                    child: const Text(
                      'Are you a citizen controlled company? Apply here',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
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
