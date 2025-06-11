import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lost_and_found/models/lost_found_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LostFoundRepository {
  String get apiUrl {
    final url = dotenv.env['apiUrl'];
    if (url == null) throw Exception('API URL not set');
    return url;
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token == null) throw Exception('Token not found');
    return token;
  }

  Future<List<LostFound>> fetchItems({String query = ''}) async {
    final token = await _getToken();
    final dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final url =
        query.isNotEmpty ? '$apiUrl/items?search=$query' : '$apiUrl/items';
    final response = await dio.get(url);
    final data = response.data['items'] as List<dynamic>;
    return data.map((item) => LostFound.fromJson(item)).toList();
  }

  Future<List<LostFound>> fetchItemsByCategory(
    String categoryId, {
    String query = '',
  }) async {
    final token = await _getToken();
    final dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await dio.get(
      '$apiUrl/items',
      queryParameters: {
        'category': categoryId,
        if (query.isNotEmpty) 'search': query,
      },
    );

    final data = response.data['items'] as List<dynamic>;
    return data.map((item) => LostFound.fromJson(item)).toList();
  }

  Future<List<Map<String, String>>> fetchCategories() async {
    final token = await _getToken();
    final dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await dio.get('$apiUrl/categories');
    final data = response.data['categories'] as List<dynamic>;
    return data
        .map((c) => {'name': c['name'] as String, 'id': c['id'] as String})
        .toList();
  }
}
