import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/models/lost_found_model.dart';
import 'package:lost_and_found/widgets/card.dart'; // Assuming LostFoundCard is here

class lostFoundItems extends StatefulWidget {
  const lostFoundItems({super.key});

  @override
  State<lostFoundItems> createState() => _LostFoundItemsState();
}

class _LostFoundItemsState extends State<lostFoundItems>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<lostFound> items = [
    lostFound(
      imagePAth: 'asset/iphone16.jpg',
      location: 'Lagos, Nigeria',
      lostStatus: 'Lost',
      daysAgo: '2 days ago',
    ),
    lostFound(
      imagePAth: 'asset/airpods.webp',
      location: 'Kigali, Rwanda',
      lostStatus: 'Found',
      daysAgo: '5 days ago',
    ),
    lostFound(
      imagePAth: 'asset/shoe.jpeg',
      location: 'Rusizi, Rwanda',
      lostStatus: 'Lost',
      daysAgo: '3 days ago',
    ),
    lostFound(
      imagePAth: 'asset/card.jpeg',
      location: 'Antalya, Turkey',
      lostStatus: 'Found',
      daysAgo: '6 days ago',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Items',
          style: GoogleFonts.brawler(
            textStyle: const TextStyle(
              fontSize: 22,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.orange,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Mobile'),
            Tab(text: 'Documents'),
            Tab(text: 'Laptop'),
          ],
        ),
        elevation: 1,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 10,
              childAspectRatio: 0.57,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return LostFoundCard(
                imagePath: item.imagePAth,
                location: item.location,
                lostStatus: item.lostStatus,
                daysAgo: item.daysAgo,
              );
            },
          ),
          GridView.builder(
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.62,
            ),
            itemBuilder: (context, index){
              final item = items[index];
              return LostFoundCard(
                  imagePath: item.imagePAth,
                  location: item.location,
                  lostStatus: item.lostStatus,
                  daysAgo: item.daysAgo
              );
            },
          ),

          const Center(child: Text('Documents category coming soon')),
          const Center(child: Text('Laptop category coming soon')),
        ],
      ),
    );

  }
}
