import 'package:flutter/material.dart';
import 'package:bhc_hackathon/view/navigation.dart';
import 'package:bhc_hackathon/view/navigation_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // BHC HOUSES FOR RENT
              _buildSection(
                title: 'BHC HOUSES FOR RENT',
                imagePaths: [
                  'lib/images/house1.png',
                  'lib/images/house1.png',
                ],
                details: [
                  {'prize': '2000 Pula', 'location': 'Gaborone'},
                  {'prize': '1800 Pula', 'location': 'Francistown'},
                ],
                path: NavigationConstants.rentHousePath,
                context: context,
              ),

              const SizedBox(height: 16),

              // BHC HOUSES FOR SALE
              _buildSection(
                title: 'BHC HOUSES FOR SALE',
                imagePaths: [
                  'lib/images/house2.png',
                  'lib/images/house2.png',
                ],
                details: [
                  {'prize': '500000 Pula', 'location': 'Maun'},
                  {'prize': '750000 Pula', 'location': 'Kasane'},
                ],
                path: NavigationConstants.buyHousePath,
                context: context,
              ),

              const SizedBox(height: 16),

              // BHC HOUSES UNDER DEVELOPMENT
              _buildSection(
                title: 'BHC HOUSES UNDER DEVELOPMENT',
                imagePaths: [
                  'lib/images/house1.png',
                  'lib/images/house1.png',
                ],
                details: [
                  {'prize': 'Price TBD', 'location': 'Serowe'},
                  {'prize': 'Price TBD', 'location': 'Palapye'},
                ],
                path: NavigationConstants.rentHousePath,
                context: context,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<String> imagePaths,
    required List<Map<String, String>> details,
    required String path,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: const Color(0xFFAD2524), // Red background color for the title section
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white, // White text color for the title
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(imagePaths.length, (index) {
              return GestureDetector(
                onTap: () {
                  _showDetailsDialog(context, imagePaths[index], details[index], path);
                },
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imagePaths[index],
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  void _showDetailsDialog(BuildContext context, String imagePath, Map<String, String> details, String path) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.red, // Red background color for the dialog image
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // White background color for the cancel icon
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.cancel, color: Colors.red), // Cancel icon color set to red
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Prize: ${details['prize']}'),
              SizedBox(height: 8),
              Text('Location: ${details['location']}'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      NavigationHelper.router.go(path);
                      Navigator.of(context).pop();
                    },
                    child: Text('Apply Now'), // Changed 'View Details' to 'Apply Now'
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
