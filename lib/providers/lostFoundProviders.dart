import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/models/lost_found_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedTabIndexProvider = StateProvider<int>((ref) => 0);

final categoriesProvider = FutureProvider<List<Map<String, String>>>((
  ref,
) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');
  if (token == null) throw Exception('Token not found in local storage');

  final dio =
      Dio()
        ..options.headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };

  final response = await dio.get('$apiUrl/categories');
  if (response.statusCode == 200) {
    final data = response.data['categories'] as List<dynamic>;
    return data
        .map<Map<String, String>>(
          (category) => {'name': category['name'], 'id': category['id']},
        )
        .toList();
  } else {
    throw Exception('Failed to fetch categories');
  }
});

final itemsProvider =
    FutureProvider.family<List<LostFound>, Map<String, dynamic>>((
      ref,
      params,
    ) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      if (token == null) throw Exception('Token not found in local storage');

      final dio =
          Dio()
            ..options.headers = {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            };

      final String query = params['query'] ?? '';
      final String? categoryId = params['categoryId'];

      final queryParameters = {
        if (query.isNotEmpty) 'search': query,
        if (categoryId != null) 'category': categoryId,
      };

      final response = await dio.get(
        '$apiUrl/items',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        final data = response.data['items'] as List<dynamic>;
        return data.map((item) => LostFound.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load items');
      }
    });
