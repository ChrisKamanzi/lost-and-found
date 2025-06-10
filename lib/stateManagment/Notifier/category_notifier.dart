import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lost_and_found/constant/api.dart';

class CategoryNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  final Dio dio;

  CategoryNotifier(this.dio) : super([]);

  String? errorMessage;
  bool isLoading = false;

  Future<void> fetchCategories() async {
    isLoading = true;
    errorMessage = null;

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('authToken');

      final options = Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': token != null ? 'Bearer $token' : '',
        },
      );

      final response = await dio.get('$apiUrl/categories', options: options);
      if (response.statusCode == 200) {
        final List<dynamic> categories = response.data['categories'];
        state = categories
            .map((cat) => {'id': cat['id'], 'name': cat['name']})
            .toList();
      } else {
        errorMessage = 'Failed to load categories. Status code: ${response.statusCode}';
        state = [];
      }
    } on DioError catch (e) {
      errorMessage =
          e.response?.data['message'] ??
              e.message ??
              'Network error occurred.';
      state = [];
    } catch (e) {
      errorMessage = 'An unexpected error occurred.';
      state = [];
    } finally {
      isLoading = false;
    }
  }
}
