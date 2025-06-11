import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod/riverpod.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/lost_found_model.dart';

class CardDetailNotifier extends StateNotifier<AsyncValue<LostFound>> {
  CardDetailNotifier() : super(const AsyncValue.loading());
  String? errorMessage;

  String get apiUrl {
    final url = dotenv.env['apiUrl'];
    if (url == null) throw Exception('API URL not set');
    return url;
  }

  Future<void> fetchItem(String itemId) async {
    try {
      state = const AsyncValue.loading();
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      if (token == null) throw Exception('Token not found');

      final dio = Dio();
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await dio.get('$apiUrl/items/$itemId');

      if (response.statusCode == 200) {
        final lostFound = LostFound.fromJson(response.data['item']);
        state = AsyncValue.data(lostFound);
      } else {
        state = AsyncValue.error('Failed to load item', StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleFavorite(String itemId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      if (token == null) return;

      final dio = Dio();
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await dio.post('$apiUrl/items/$itemId/favorite');

      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchItem(itemId); // refresh data
      }
    } catch (e) {
      if (e is DioError) {
        errorMessage = e.response?.data['message'] ?? 'Something went wrong.';
      } else {
        errorMessage = 'Unexpected error.';
      }
    }
  }
}


