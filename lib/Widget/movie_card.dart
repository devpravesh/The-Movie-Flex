import 'package:flutter/material.dart';

import 'constant.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String releaseDate;
  final double score; // Changed to double to represent percentage

  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.releaseDate,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              imageUrl,
              width: 200,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 75,
            left: 8,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                  child: CircularProgressIndicator(
                    value: score / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                    strokeWidth: 4.0,
                  ),
                ),
                Text(
                  '${score.toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 8,
            right: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  formatDate(releaseDate),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Options Menu Icon
        ],
      ),
    );
  }
}
