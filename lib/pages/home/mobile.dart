import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constant/api.dart';
import '../../models/lost_found_model.dart';
import '../../widgets/card.dart';

class mobile extends StatefulWidget {
  const mobile({super.key});

  @override
  State<mobile> createState() => _mobileState();
}

class _mobileState extends State<mobile> {
  @override
  Future<List<lostFound>> fetchItems() async {
    final response = await http.get(Uri.parse('$apiUrl/items?category=mobile'));

    print('🟢 Response status: ${response.statusCode}');
    print('📦 Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData is List) {
        return jsonData.map((item) => lostFound.fromJson(item)).toList();
      } else if (jsonData is Map && jsonData.containsKey('items')) {
        final List<dynamic> data = jsonData['items'];
        return data.map((item) => lostFound.fromJson(item)).toList();
      } else {
        print('❓ Unexpected format: $jsonData');
        throw Exception('Unexpected API response format');
      }
    } else {
      print('❌ Failed to fetch items: ${response.statusCode}');
      throw Exception('Failed to load items ${response.statusCode}');
    }
  }

  late Future<List<lostFound>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = fetchItems();
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<lostFound>>(
      future: _futureItems,
      builder: (context, snapshot) {
        print('📊 FutureBuilder state: ${snapshot.connectionState}');

        if (snapshot.connectionState == ConnectionState.waiting) {
          print('⏳ Waiting for data...');
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('❗ Error in FutureBuilder: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('⚠️ No data received or list is empty');
          return const Center(child: Text('No items found'));
        }

        final items = snapshot.data!;
        print('✅ Rendering ${items.length} items in grid');

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
              title: item.title,
              imagePath: item.imagePath,
              location: item.location,
              lostStatus: item.lostStatus,
              daysAgo: item.daysAgo,
            );
          },
        );
      },
    );
  }
}
