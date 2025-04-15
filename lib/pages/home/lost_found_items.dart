import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lost_and_found/constant/api.dart';
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

  Future<List<lostFound>> fetchItems() async {
    final response = await http.get(Uri.parse('$apiUrl/items'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((item) => lostFound.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items ${response.statusCode}');
    }
  }

  late Future<List<lostFound>> _futureItems;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _futureItems = fetchItems();
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
          FutureBuilder<List<lostFound>>(
            future: _futureItems,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No items found'));
              }

              final items = snapshot.data!;
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return LostFoundCard(
                    imagePath: item.imagePath, // Just one image now
                    location: item.location,
                    lostStatus: item.lostStatus,
                    daysAgo: item.daysAgo,
                  );

                },
              );
            },
          ),
          const Center(child: Text('Mobile category coming soon')),
          const Center(child: Text('Documents category coming soon')),
          const Center(child: Text('Laptop category coming soon')),
        ],
      ),
    );
  }
}
