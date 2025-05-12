import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/favoriteModel.dart';

final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, List<FavoriteItem>>(
      FavoritesNotifier.new,
    );

class FavoritesNotifier extends AsyncNotifier<List<FavoriteItem>> {
  @override
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
