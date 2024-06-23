
import 'package:bhc_hackathon/view/navigation.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            // BHC logo 
            Image.asset(
              'lib/images/BHCLogo.png',
              width: 128,
              height: 128,
            ),
            //const Text('accommodating your future', 
            //style: TextStyle(
              //color: Color(0xFFAD2524),
            //),),
            const SizedBox(width: double.infinity, height: 16),


            const TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
            ),
            const SizedBox(width: double.infinity, height: 16),
            const TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Phone",
              ),
            ),
            const SizedBox(width: double.infinity, height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
            ),
            const SizedBox(width: double.infinity, height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Repeat password",
              ),
            ),
            const SizedBox(width: double.infinity, height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: (){
                },
                child: const Text("Sign Up"),
              ),
            ),
            Row(
              children: [
                const Text("Already have an account?"),
                TextButton(onPressed: (){
                  NavigationHelper.router.go(
                    NavigationConstants.signInPath,
                  );
                },child: const Text("Sign in here")),
              ],
            )
          ],
        ),
      ),

    );
  }
}
