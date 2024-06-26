import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FAQItem(
              question: 'What is BHC?',
              answer:
                  'BHC (Botswana Housing Corporation) is a government-owned entity responsible for providing affordable housing solutions to citizens.',
            ),
            FAQItem(
              question: 'Can non-Citizens buy BHC Houses?',
              answer:
                  'No, BHC houses are typically reserved for citizens of Botswana as part of government housing policies.',
            ),
            FAQItem(
              question: 'Are BHC houses negotiable?',
              answer:
                  'The pricing of BHC houses is generally fixed, but there may be some flexibility depending on specific circumstances.',
            ),
            FAQItem(
              question: 'Can I buy a BHC house I find vacant?',
              answer:
                  'Yes, vacant BHC houses are available for purchase to eligible citizens through official channels.',
            ),
            FAQItem(
              question: 'Does BHC have a website?',
              answer:
                  'Yes, BHC has an official website where you can find information about their services, housing options, and more.',
            ),
            FAQItem(
              question: 'What is a sale agreement?',
              answer:
                  'A sale agreement is a legal document outlining the terms and conditions of a property sale, including price, payment terms, and transfer of ownership.',
            ),
            FAQItem(
              question: 'Does BHC allow house swapping?',
              answer:
                  'No, BHC does not facilitate house swapping between individuals. Property transactions are conducted through official channels.',
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({
    required this.question,
    required this.answer,
    Key? key,
  }) : super(key: key);

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            title: Text(
              widget.question,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(widget.answer),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FAQPage(),
  ));
}