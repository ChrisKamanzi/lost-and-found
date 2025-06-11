import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/favorite_model.dart';

class FavoritesNotifier extends AsyncNotifier<List<FavoriteItem>> {
  @override


  String get apiUrl {
    final url = dotenv.env['apiUrl'];
    if (url == null) throw Exception('API URL not set');
    return url;
  }

  Future<List<FavoriteItem>> build() async {
    final dio = Dio();
    final token = await _getToken();

    if (token == null) {
      throw Exception('No token found');
    }
    final response = await dio.get(
      '$apiUrl/favorites',
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final List data = response.data['favorites_items'];
    return data.map((e) => FavoriteItem.fromJson(e)).toList();
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
}
