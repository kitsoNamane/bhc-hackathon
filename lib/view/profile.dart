import 'package:bhc_hackathon/view/navigation_constants.dart';
import 'package:bhc_hackathon/view_model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget showPaymentHistory(bool isNewCustomer, ApplicationState p) {
    return !isNewCustomer ? Row(children: [
      const Divider(thickness: 1),
      const Icon(Icons.receipt_long_outlined),
      const SizedBox(width: 16),
      const Text("Payment History"),
      const Spacer(),
      IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: () {
        p.toggleLoggedInStatus();
      },),
    ],) : const SizedBox(width: 0, height: 0);
  }

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<ApplicationState>(context);
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
                  Row(children: [
                    const Icon(Icons.comment_outlined),
                    const SizedBox(width: 16),
                    const Text("Report"),
                    const Spacer(),
                    IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: () {
                      p.toggleLoggedInStatus();
                    },),
                  ],),
                  const Divider(thickness: 1),
                  if (p.loggedIn) Row(children: [
                    const Icon(Icons.receipt_long_outlined),
                    const SizedBox(width: 16),
                    const Text("Payment History"),
                    const Spacer(),
                    IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: () {
                      p.toggleLoggedInStatus();
                    },),
                  ],)
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: (){
                p.router.go(
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