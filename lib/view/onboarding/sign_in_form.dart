
import 'package:bhc_hackathon/view/navigation.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => SignInFormState();
}

class SignInFormState extends State<SignInForm> {
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
              //color: Color(0xFFAD2524), color: Color(0xFF8FD400),
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
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: (){
                    NavigationHelper.router.push(
                      NavigationConstants.resetPasswordPath,
                    );
                  },
                  child: const Text("Forgot Password?")
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: (){
                    NavigationHelper.router.go(
                      NavigationConstants.homePath,
                      
                    );
                  },
                  
                  child: const Text("Sign In",
                  style: TextStyle(
                    color: Color(0xFFAD2524), 
                  ),),
              ),
            ),
            Row(
              children: [
                const Text("Don't have an account?"),
                TextButton(onPressed: (){
                 NavigationHelper.router.push(
                   NavigationConstants.signUpPath,
                 );
                },child: const Text("Sign up here")),
              ],
            )
          ],
        ),
      ),

    );
  }
}
