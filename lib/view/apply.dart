
import 'package:flutter/material.dart';
import 'package:bhc_hackathon/view/navigation.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';
import 'package:provider/provider.dart';

import '../view_model/app_state.dart';

class ApplyPage extends StatefulWidget {
  const ApplyPage({super.key});

  @override
  State<ApplyPage> createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  bool isRent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ToggleButtons(
                  borderRadius: BorderRadius.circular(8.0),
                  isSelected: [isRent, !isRent],
                  onPressed: (index) {
                    setState(() {
                      isRent = index == 0;
                    });
                  },
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 24,
                      child: const Center(
                        child: Text(
                          'Rent',
                          style: TextStyle(fontWeight: FontWeight.bold), // Made bold
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 24,
                      child: const Center(
                        child: Text(
                          'Buy',
                          style: TextStyle(fontWeight: FontWeight.bold), // Made bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isRent
                          ? 'Consider this before you rent:\n'
                          : 'Consider this before you buy:\n',
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold), // Made bold
                    ),
                    Text(
                      isRent
                          ? '• You must be 21 years or older\n'
                              '• 30% of your monthly salary must be equal or more than your rent.\n'
                              '• You must never have been evicted in the past 5 years for breach of contract\n'
                          : '• Ensure you have a stable source of income.\n'
                              '• Check the property thoroughly before buying.\n'
                              '• Consult with a real estate agent.\n',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Provider.of<ApplicationState>(context).router.go(
                        isRent
                            ? NavigationConstants.individualHousePath
                            : NavigationConstants.individualHousePath,
                      );
                  },
                  child: Text(
                    isRent ? 'Start rent application' : 'Start buy application',
                  ),
                ),
              ),
              const SizedBox(height: 24), // Added space to position the image
              Image.asset(
                'lib/images/applyimg.png', // Adjust the path to your image
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200, // Adjusted height as necessary
              ),
            ],
          ),
        ),
      ),
    );
  }
}
