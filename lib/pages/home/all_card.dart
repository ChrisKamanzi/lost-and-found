import 'package:flutter/material.dart';
import 'package:lost_and_found/widgets/card.dart';

class all_cards extends StatefulWidget {
  const all_cards({super.key});

  @override
  State<all_cards> createState() => _homepageState();
}

class _homepageState extends State<all_cards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: LostFoundCard(
                  imagePath: 'asset/iphone16.jpg',
                  location: 'lagos,Nigeria',
                  lostStatus: 'Lost',
                  daysAgo: '2 days ago',
                ),
              ),

              Expanded(
                child: LostFoundCard(
                  imagePath: 'asset/airpods.webp',
                  location: 'Kigali,Rwanda',
                  lostStatus: 'Found',
                  daysAgo: '5 days ago',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: LostFoundCard(
                  imagePath: 'asset/shoe.jpeg',
                  location: 'Rusizi,Rwanda',
                  lostStatus: 'Lost',
                  daysAgo: '2 days ago',
                ),
              ),

              Expanded(
                child: LostFoundCard(
                  imagePath: 'asset/card.jpeg',
                  location: 'Bujumbura,Burundi',
                  lostStatus: 'Found',
                  daysAgo: 'Today',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

