import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bhc_hackathon/view/navigation.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BHC Products'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40, // Adjust height as necessary
              child: FilledButton(
                onPressed: () {
                  NavigationHelper.router.go(
                    NavigationConstants.applyPath,
                  );
                },
                child: const Text(
                  'APPLY NOW',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Search Bar
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

            // Image Carousel
            CarouselSlider(
              items: [
                Image.asset('lib/images/swiper1.png', fit: BoxFit.cover),
                Image.asset('lib/images/swiper2.png', fit: BoxFit.cover),
                Image.asset('lib/images/swiper3.png', fit: BoxFit.cover),
              ],
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
            ),
            const SizedBox(height: 16),

            // List of Product Cards
            const Text(
              'BHC PROPERTIES FOR RENT',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildProductCard(
              context,
              'House 1',
              'Gaborone',
              'P1500',
              '3 BHK',
              'lib/images/house1.png',
              'The development is complete with access roads and modern amenities and it is located within reach of many centres in Gaborone such as the Mall and several other government facilities.\n\nProperty Types Available In This Area\nType 59\nType 60\nType 70A\n\nContact Sales\nMr. Khumoetsile Bagai\nTel: (+267) 4921075\nEmail: kbagai@bhc.bw',
            ),
            _buildProductCard(
              context,
              'House 2',
              'Francistown',
              'P1200',
              '2 BHK',
              'lib/images/renthouse1.2.png',
              'The development is complete with access roads and modern amenities and it is located within reach of many centres in Francistown such as the Mall and several other government facilities.\n\nProperty Types Available In This Area\nType 59\nType 60\nType 70A\n\nContact Sales\nMr. Khumoetsile Bagai\nTel: (+267) 4921075\nEmail: kbagai@bhc.bw',
            ),
            const SizedBox(height: 16),

            const Text(
              'BHC PROPERTIES FOR SALE',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildProductCard(
              context,
              'House 3',
              'Molepolole',
              'P500,000',
              '4 BHK',
              'lib/images/buyhouse1.1.png',
              'The development is complete with access roads and modern amenities and it is located within reach of many centres in Molepolole such as the Mall and several other government facilities.\n\nProperty Types Available In This Area\nType 59\nType 60\nType 70A\n\nContact Sales\nMr. Khumoetsile Bagai\nTel: (+267) 4921075\nEmail: kbagai@bhc.bw',
            ),
            _buildProductCard(
              context,
              'House 4',
              'Maun',
              'P450,000',
              '3 BHK',
              'lib/images/buyhouse1.2.png',
              'The development is complete with access roads and modern amenities and it is located within reach of many centres in Maun such as the Mall and several other government facilities.\n\nProperty Types Available In This Area\nType 59\nType 60\nType 70A\n\nContact Sales\nMr. Khumoetsile Bagai\nTel: (+267) 4921075\nEmail: kbagai@bhc.bw',
            ),
            const SizedBox(height: 16),

            const Text(
              'BHC PROPERTIES UNDER DEVELOPMENT',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildProductCard(
              context,
              'House 5',
              'Palapye',
              'P300,000',
              '2 BHK',
              'lib/images/devhouse1.1.png',
              'The development is complete with access roads and modern amenities and it is located within reach of many centres in Palapye such as the Mall and several other government facilities.\n\nProperty Types Available In This Area\nType 59\nType 60\nType 70A\n\nContact Sales\nMr. Khumoetsile Bagai\nTel: (+267) 4921075\nEmail: kbagai@bhc.bw',
            ),
            _buildProductCard(
              context,
              'House 6',
              'Selibe Phikwe',
              'P350,000',
              '3 BHK',
              'lib/images/devhouse1.2.png',
              'The development is complete with access roads and modern amenities and it is located within reach of many centres in Selibe Phikwe such as the Mall and several other government facilities.\n\nProperty Types Available In This Area\nType 59\nType 60\nType 70A\n\nContact Sales\nMr. Khumoetsile Bagai\nTel: (+267) 4921075\nEmail: kbagai@bhc.bw',
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
      String description) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Location: $location'),
            Text('Price: $price'),
            Text('Type: $type'),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navigate to detail screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        title: title,
                        imagePath: imagePath,
                        description: description,
                      ),
                    ),
                  );
                },
                child: const Text('Read More'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;

  const DetailPage({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
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
          ],
        ),
      ),
    );
  }
}
