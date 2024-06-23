import 'package:bhc_hackathon/view/navigation.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';
import 'package:flutter/material.dart';

class RentForm extends StatefulWidget {
  const RentForm({super.key});

  @override
  State<RentForm> createState() => RentFormState();
}

class RentFormState extends State<RentForm> {
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
               Text(
                'BHC REGISTRATION FORM TO RENT PROPERTY',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

            const TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "FirstName",
              ),
            ),
            const SizedBox(width: double.infinity, height: 16),
            const TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "LastName",
              ),
            ),
           
            const SizedBox(width: double.infinity, height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Gender",
              ),
            ),
            const SizedBox(width: double.infinity, height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: (){
                },
                child: const Text("Register"),
              ),
            ),
            
          ],
        ),
      ),

    );
  }
}
