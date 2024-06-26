
import 'package:flutter/material.dart';
import 'package:bhc_hackathon/view/navigation.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';
import 'package:provider/provider.dart';

import '../view_model/app_state.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BHC Products'),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'BHC Properties',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),// Search Bar
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),

            _buildProductCard(
              context,
              'Mid Cost House 1',
              'Gaborone',
              'Price for rent per Month: P1500',
              'Rental',
              'lib/images/house1.png',
              'The development is complete with access roads and modern amenities and it is located within reach of many centres in Gaborone such as the Mall and several other government facilities.\n\n'
              'Location: Gaborone\n'
              'Type: Rental\n'
              'Price for Rent per Month: P1500\n\n'
              'Contact Sales\nMr. Khumoetsile Bagai\n'
              'Tel: (+267) 4921075\nEmail: kbagai@bhc.bw',
              NavigationConstants.individualHousePath,
              'Apply Now',
            ),
            _buildProductCard(
              context,
              'Mid Cost House 2',
              'Francistown',
              'Price for rent per Month: P1200',
              'Rental',
              'lib/images/renthouse1.2.png',
              'The development is complete with access roads and modern amenities and it is located within reach of many centres in Francistown such as the Mall and several other government facilities.\n\nProperty Types Available In This Area\nType 59\nType 60\nType 70A\n\nContact Sales\nMr. Khumoetsile Bagai\nTel: (+267) 4921075\nEmail: kbagai@bhc.bw',
              NavigationConstants.individualHousePath,
              'Apply Now',
            ),
            const SizedBox(height: 16),

            const Text(
              'BHC PROPERTIES FOR SALE',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildProductCard(
              context,
              'Mid Cost House 3',
              'Molepolole',
              'Price: P500,000',
              'Sale',
              'lib/images/buyhouse1.1.png',
              'The development is complete with access roads and modern amenities and it is located within reach of many centres in Molepolole such as the Mall and several other government facilities.\n\nProperty Types Available In This Area\nType 59\nType 60\nType 70A\n\nContact Sales\nMr. Khumoetsile Bagai\nTel: (+267) 4921075\nEmail: kbagai@bhc.bw',
              NavigationConstants.individualHousePath,
              'Buy Now',
            ),
            _buildProductCard(
              context,
              'Mid Cost House 4',
              'Maun',
              'Price: P450,000',
              'Sale',
              'lib/images/buyhouse1.2.png',
              'The development is complete with access roads and modern amenities and it is located within reach of many centres in Maun such as the Mall and several other government facilities.\n\nProperty Types Available In This Area\nType 59\nType 60\nType 70A\n\nContact Sales\nMr. Khumoetsile Bagai\nTel: (+267) 4921075\nEmail: kbagai@bhc.bw',
              NavigationConstants.individualHousePath,
              'Buy Now',
            ),
            const SizedBox(height: 16),

            const Text(
              'BHC PROPERTIES UNDER DEVELOPMENT',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildProductCard(
              context,
              'Mid Cost House 5',
              'Palapye',
              'Asking Price: P300,000',
              'Development',
              'lib/images/devhouse1.1.png',
              'The development is complete with access roads and modern amenities and it is located within reach of many centres in Palapye such as the Mall and several other government facilities.\n\nProperty Types Available In This Area\nType 59\nType 60\nType 70A\n\nContact Sales\nMr. Khumoetsile Bagai\nTel: (+267) 4921075\nEmail: kbagai@bhc.bw',
              NavigationConstants.individualHousePath,
              'Apply Now',
            ),
            _buildProductCard(
              context,
              'Mid Cost House 6',
              'Selibe Phikwe',
              'Asking Price: P350,000',
              'Development',
              'lib/images/devhouse1.2.png',
              'The development is complete with access roads and modern amenities and it is located within reach of many centres in Selibe Phikwe such as the Mall and several other government facilities.\n\nProperty Types Available In This Area\nType 59\nType 60\nType 70A\n\nContact Sales\nMr. Khumoetsile Bagai\nTel: (+267) 4921075\nEmail: kbagai@bhc.bw',
              NavigationConstants.individualHousePath,
              'Apply Now',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    String title,
    String location,
    String price,
    String type,
    String imagePath,
    String description,
    String navigatePath,
    String buttonText,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              title: title,
              imagePath: imagePath,
              description: description,
              navigatePath: navigatePath,
              buttonText: buttonText,
            ),
          ),
        );
      },
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(thickness: 4),
              const SizedBox(height: 8),
              _buildPill(location),
              _buildPill(type),
              _buildPill(price.contains('Price for rent') ? 'Price for rent per Month' : price.contains('Asking Price') ? 'Asking Price' : 'Price', price),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPill(String text, [Color color = Colors.green]) {
    return Container(
      margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(text),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  final String navigatePath;
  final String buttonText;

  const DetailPage({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.navigatePath,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Provider.of<ApplicationState>(context).router.go(navigatePath);
                },
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
