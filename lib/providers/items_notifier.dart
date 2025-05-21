import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show StateNotifier;
import 'package:lost_and_found/models/lost_found_items_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/api.dart';

class ItemsNotifier extends StateNotifier<List<LostFoundItems>?> {
  ItemsNotifier() : super(null);

  Future<List<LostFoundItems>> fetchItems({String? token}) async {
    final prefs = await SharedPreferences.getInstance();
    final token2 = prefs.getString('authToken');

    final Dio _dio = Dio();
    try {
      final response = await _dio.get(
        '$apiUrl/items',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token2',
          },
        ),
      );
      print('$token2');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['items'];
        List<LostFoundItems> allItems = List.from(
          (response.data['items'] as List).map((e) => LostFoundItems.fromJson(e)),
        );
        final items = data.map((json) => LostFoundItems.fromJson(json)).toList();
        state = allItems;
        return allItems;
      } else {
        print("Failled to catch Items ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print('Error $e}');
      return [];
    }
  }
}
