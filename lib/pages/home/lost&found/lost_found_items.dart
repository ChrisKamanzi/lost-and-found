import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/models/lost_found_model.dart';
import 'package:lost_and_found/providers/providers.dart';
import 'package:lost_and_found/widgets/card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LostFoundItemsScreen extends ConsumerStatefulWidget {
  const LostFoundItemsScreen({super.key});

  @override
  ConsumerState<LostFoundItemsScreen> createState() =>
      _LostFoundItemsScreenState();
}

class _LostFoundItemsScreenState extends ConsumerState<LostFoundItemsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, String>> categories = [];
  late List<Future<List<LostFound>>> categoryFutures;
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  Future<List<LostFound>> fetchItems({String query = ''}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      throw Exception('Token not found in local storage');
    }

    final url =
        query.isNotEmpty ? '$apiUrl/items?search=$query' : '$apiUrl/items';

    Dio dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data['items'] as List<dynamic>;
        return data.map((item) => LostFound.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load items ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching items: $e');
      throw e;
    }
  }

  Future<List<LostFound>> fetchItemsByCategory(
    String categoryId, {
    String query = '',
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      throw Exception('Token not found in local storage');
    }

    Dio dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final queryParameters = {
      'category': categoryId,
      if (query.isNotEmpty) 'search': query,
    };

    try {
      final response = await dio.get(
        '$apiUrl/items',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        final data = response.data['items'] as List<dynamic>;
        return data.map((item) => LostFound.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load items for category $categoryId');
      }
    } catch (e) {
      print('Error fetching items for category $categoryId: $e');
      throw e;
    }
  }

  Future<List<Map<String, String>>> fetchCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      throw Exception('Token not found in local storage');
    }

    Dio dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.get('$apiUrl/categories');

      if (response.statusCode == 200) {
        final data = response.data['categories'] as List<dynamic>;
        return data.map<Map<String, String>>((category) {
          return {'name': category['name'], 'id': category['id']};
        }).toList();
      } else {
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      throw e;
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
          final categoryId = c['id']!;
          if (!isAllTab && categories[selectedIndex - 1]['id'] == categoryId) {
            return fetchItemsByCategory(categoryId, query: query);
          }
          return fetchItemsByCategory(categoryId);
        }),
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(lostFoundItemsProvider.notifier).fetchItems();
    });
    fetchCategories().then((fetchedCategories) {
      setState(() {
        categories = fetchedCategories;
        _tabController = TabController(
          length: categories.length + 1,
          vsync: this,
        );
        categoryFutures = [
          fetchItems(),
          ...categories.map((c) => fetchItemsByCategory(c['id']!)),
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
      ...categories.map((c) => Tab(text: c['name'])),
    ];
  }

  List<Widget> buildTabViews() {
    return categoryFutures.map((future) {
      return FutureBuilder<List<LostFound>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.orange,));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items found'));
          }

          final items = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 10,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return LostFoundCard(
                itemId: item.id,
                title: item.title,
                imagePath: item.imagePath,
                location: "${item.location['district']}",
                lostStatus: item.postType,
                daysAgo: item.postedAt,
              );
            },
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var items = ref.watch(lostFoundItemsProvider);
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
              ? const Center(child: CircularProgressIndicator(color: Colors.orange,))
              : TabBarView(
                controller: _tabController,
                children: buildTabViews(),
              ),
    );
  }
}
