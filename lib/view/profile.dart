import 'package:bhc_hackathon/view/navigation.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget showPaymentHistory(bool isNewCustomer) {
    return !isNewCustomer ? const Row(children: [
      Divider(thickness: 1),
      Icon(Icons.receipt_long_outlined),
      SizedBox(width: 16),
      Text("Payment History"),
      Spacer(),
      Icon(Icons.arrow_forward_ios),
    ],) : const SizedBox(width: 0, height: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(
            Icons.account_circle_rounded,
            size: 128,
            color: Theme.of(context).colorScheme.primary,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                style: BorderStyle.solid,
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                 const Align(
                    alignment: Alignment.topLeft,
                    child: Text("General", style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  const SizedBox(height: 24),
                  const Row(children: [
                    Icon(Icons.person_2_outlined),
                    SizedBox(width: 16),
                    Text("Kitso Namane"),
                  ],),
                  const Divider(thickness: 1),
                  const Row(children: [
                    Icon(Icons.email_outlined),
                    SizedBox(width: 16),
                    Text("kitso@gmail.com"),
                  ],),
                  const Divider(thickness: 1),
                  const Row(children: [
                    Icon(Icons.phone_iphone_outlined),
                    SizedBox(width: 16),
                    Text("77777777"),
                  ],),
                  const Divider(thickness: 1),
                  const Row(children: [
                    Icon(Icons.comment_outlined),
                    SizedBox(width: 16),
                    Text("Report"),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                  ],),
                  showPaymentHistory(NavigationConstants.isNewCustomer),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: (){
                NavigationHelper.router.go(
                  NavigationConstants.signInPath
                );
              },
              child: const Text("Sign Out"),
            ),
          ),
        ],
      ),
    );
  }
}