import 'package:flutter/material.dart';
import 'package:bhc_hackathon/view/navigation.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';
import 'package:bhc_hackathon/components/square_tile.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});



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

             //Landin Page
              Text(
                'House avaliable in Mogoditshane',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

           
          // Property Pictures
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  
                  SquareTile(imagePath: 'lib/images/house2.png'),

                  SizedBox(width: 25),

                 
                  SquareTile(imagePath: 'lib/images/house2.png')
                ],
              ),
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
              


            ],
          ),
        ),
      ),
    );
  }
}
