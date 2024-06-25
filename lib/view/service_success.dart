import 'package:flutter/material.dart';

class ServiceSuccessPage extends StatelessWidget {
  const ServiceSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: const Center(
        child: Text("Fault Created Successfully"),
      ),
    );
  }
}
