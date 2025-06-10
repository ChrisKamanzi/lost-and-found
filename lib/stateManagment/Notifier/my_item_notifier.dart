import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/my_item_model.dart';

class MyItemsNotifier extends StateNotifier<AsyncValue<List<MyItem>>> {
  MyItemsNotifier() : super(AsyncLoading()) {
    fetchMyItems();
  }
String? errorMessage;

  Future<void> fetchMyItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        throw Exception('Auth token not found');
      }

      final dio = Dio();
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      final response = await dio.get('$apiUrl/items');

      final allItems = List<Map<String, dynamic>>.from(response.data['items']);
      final myItems =
          allItems
              .where((item) => item['posted_by']['is_myItem'] == true)
              .map((item) => MyItem.fromJson(item))
              .toList();

      state = AsyncData(myItems);
    } catch (e, st) {

      if (e is DioError) {
        errorMessage =
            e.response?.data['message'] ??
                'Something went wrong. Please try again.';
      } else {
        errorMessage = 'An unexpected error occurred.';
      }
      state = AsyncError(e, st);
    }
  }
}
