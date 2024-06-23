import 'package:flutter/material.dart';
import 'package:bhc_hackathon/view/navigation.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';

class ApplyPage extends StatelessWidget {
  const ApplyPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),



                  SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: (){
                NavigationHelper.router.go(
                  NavigationConstants.signInPath
                );
              },
              child: const Text("Apply to Rent"),
            ),
          ),
              const SizedBox(height: 16),
              


               SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: (){
                NavigationHelper.router.go(
                  NavigationConstants.signInPath
                );
              },
              child: const Text("Apply to Buy"),
            ),
          ),
              
              const SizedBox(height: 16),

               SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: (){
                NavigationHelper.router.go(
                  NavigationConstants.signInPath
                );
              },
              child: const Text("Apply to reserve"),
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}