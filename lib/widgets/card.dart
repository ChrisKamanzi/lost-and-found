import 'package:flutter/material.dart';
import 'dart:io';
import 'package:go_router/go_router.dart';

class LostFoundCard extends StatelessWidget {
  final String itemId;
  final String title;
  final String imagePath;
  final String location;
  final String lostStatus;
  final String daysAgo;

  const LostFoundCard({
    Key? key,
    required this.itemId,
    required this.title,
    required this.imagePath,
    required this.location,
    required this.lostStatus,
    required this.daysAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 1),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child:
                    imagePath.startsWith('file://')
                        ? Image.file(File(imagePath))
                        : Image.network(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported),
                          width: 120,
                          height: 120,
                        ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white54
                            : Colors.blueGrey,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      location,
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.blueGrey,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  lostStatus,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //  const SizedBox(height: 5),
              Text(
                '$daysAgo ago',
                style: TextStyle(
                  fontSize: 12,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 1),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/cardDetail/$itemId'),
                  icon: const Icon(Icons.info),
                  label: const Text('More Info'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
