import 'package:bhc_hackathon/view_model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
              child: Consumer<ApplicationState>(
                builder: (context, state, child) {
                  return Column(
                  children: [
                   const Align(
                      alignment: Alignment.topLeft,
                      child: Text("General", style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                    const SizedBox(height: 24),
                    Row(children: [
                      const Icon(Icons.person_2_outlined),
                      const SizedBox(width: 16),
                      Text(state.currentUser?.email!.split("@")[0] ?? ""),
                    ],),
                    const Divider(thickness: 1),
                    Row(children: [
                      const Icon(Icons.email_outlined),
                      const SizedBox(width: 16),
                      Text(state.currentUser?.email! ?? ""),
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
                      },),
                    ],),
                    const Divider(thickness: 1),
                    if (state.currentUser?.isExistingCustomer ?? false) Row(children: [
                      const Icon(Icons.receipt_long_outlined),
                      const SizedBox(width: 16),
                      const Text("Payment History"),
                      const Spacer(),
                      IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: () {
                      },),
                    ],)
                  ],
                );},
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () async {
                await p.signOut();
              },
              child: const Text("Sign Out"),
            ),
          ),
        ],
      ),
    );
  }
}