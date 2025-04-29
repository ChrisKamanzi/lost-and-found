import 'package:flutter/material.dart';
class LostFoundCardd extends StatelessWidget {

  final String imagePath;
  final String location;
  final String lostStatus;
  final String daysAgo;

  const LostFoundCardd({
    super.key,
    required this.imagePath,
    required this.location,
    required this.lostStatus,
    required this.daysAgo,

  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
              errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(location, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(lostStatus),
                Text('Posted: $daysAgo'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
