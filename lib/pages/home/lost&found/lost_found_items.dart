import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/models/lost_found_model.dart';
import 'package:lost_and_found/pages/home/lost&found/card_detail.dart';
import 'package:lost_and_found/widgets/card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class lostFoundItems extends StatefulWidget {
  const lostFoundItems({super.key});

  @override
  State<lostFoundItems> createState() => _LostFoundItemsState();
}

class _LostFoundItemsState extends State<lostFoundItems>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, String>> categories = [];
  late List<Future<List<lostFound>>> categoryFutures;
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  Future<List<lostFound>> fetchItems({String query = ''}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      throw Exception('Token not found in local storage');
    }

    final url =
        query.isNotEmpty ? '$apiUrl/items?search=$query' : '$apiUrl/items';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> data = json['items'];
      return data.map((item) => lostFound.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items ${response.statusCode}');
    }
  }

  Future<List<lostFound>> fetchItemsByCategory(
    String slug, {
    String query = '',
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    final url =
        query.isNotEmpty
            ? '$apiUrl/items?category=$slug&search=$query'
            : '$apiUrl/items?category=$slug';

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> data = json['items'];
      return data.map((item) => lostFound.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items for $slug');
    }
  }

  Future<List<Map<String, String>>> fetchCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      throw Exception('Token not found in local storage');
    }

    final response = await http.get(
      Uri.parse('$apiUrl/categories'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> data = json['categories'];
      return data.map<Map<String, String>>((category) {
        return {
          'name': category['name'],
          'slug': category['name'].toString().toLowerCase(),
        };
      }).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  void searchItems(String query) {
    final selectedIndex = _tabController.index;
    final isAllTab = selectedIndex == 0;

    setState(() {
      searchQuery = query;
      categoryFutures = [
        fetchItems(query: query),
        ...categories.map((c) {
          final slug = c['slug']!;
          if (!isAllTab && categories[selectedIndex - 1]['slug'] == slug) {
            return fetchItemsByCategory(slug, query: query);
          }
          return fetchItemsByCategory(slug);
        }),
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCategories().then((fetchedCategories) {
      setState(() {
        categories = fetchedCategories;
        _tabController = TabController(
          length: categories.length + 1,
          vsync: this,
        );
        categoryFutures = [
          fetchItems(),
          ...categories.map((c) => fetchItemsByCategory(c['slug']!)),
        ];
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  List<Tab> buildTabs() {
    return [
      const Tab(text: 'All'),
      ...categories.map((c) => Tab(text: c['name'])).toList(),
    ];
  }

  List<Widget> buildTabViews() {
    return categoryFutures.map((future) {
      return FutureBuilder<List<lostFound>>(
        future: future,
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
                itemId: item.id,
                title: item.title,
                imagePath: item.imagePath,
                location: item.location,
                lostStatus: item.postType,
                daysAgo: item.postedAt,
             //   => context.go('/cardDetail/${item.id}'),
              );
            },
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search items...',
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () => searchItems(searchController.text),
            ),
          ),
          style: GoogleFonts.brawler(
            textStyle: const TextStyle(fontSize: 18, color: Colors.black87),
          ),
          onSubmitted: searchItems,
        ),
        bottom:
            categories.isEmpty
                ? null
                : TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.orange,
                  indicatorWeight: 3,
                  tabs: buildTabs(),
                ),
        elevation: 1,
      ),
      body:
          categories.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                controller: _tabController,
                children: buildTabViews(),
              ),
    );
  }
}
