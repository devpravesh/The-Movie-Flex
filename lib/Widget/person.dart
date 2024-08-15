import 'package:flutter/material.dart';

class CreditPersonWidget extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String proficiency;

  const CreditPersonWidget({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.proficiency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image of the Credit Person
        ClipRRect(
          borderRadius: BorderRadius.circular(50.0), // Circular image
          child: Image.network(
            imageUrl,
            width: 90,
            height: 90,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 8),

        // Name of the Credit Person
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),

        // Proficiency of the Credit Person
        Text(
          proficiency,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
