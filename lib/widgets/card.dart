import 'package:flutter/material.dart';
import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/generated/app_localizations.dart';

class LostFoundCard extends StatelessWidget {
  final String? itemId;
  final String? title;
  final String? imagePath;
  final String? location;
  final String? lostStatus;
  final String? daysAgo;

  const LostFoundCard({
    Key? key,
    this.itemId,
    this.title,
    this.imagePath,
    this.location,
    this.lostStatus,
    this.daysAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 1),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child:
                    imagePath!.startsWith('file://')
                        ? Image.file(File(imagePath!))
                        : Image.network(
                          imagePath!,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => SizedBox(
                                width: 120,
                                height: 120,
                                child: Icon(Icons.image_not_supported),
                              ),
                          width: 120,
                          height: 120,
                        ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white54
                            : Colors.blueGrey,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      location ?? ' ',
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
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  lostStatus ?? '',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
              SizedBox(height: 1),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/cardDetail/$itemId'),
                  icon: Icon(Icons.info),
                  label: Text(AppLocalizations.of(context)!.moreInfo),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.orange.shade700,
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
