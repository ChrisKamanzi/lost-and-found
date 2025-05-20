import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lost_and_found/constant/api.dart';

class CategoryNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  final Dio dio;

  CategoryNotifier(this.dio) : super([]);

  Future<void> fetchCategories() async {
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
        print('Failed to load categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.response?.data}');
        print('Error status code: ${e.response?.statusCode}');
      } else {
        print('Error fetching categories: $e');
      }
    }
  }
}

final dioProvider = Provider((ref) {
  return Dio(BaseOptions(headers: {'Accept': 'application/json'}));
});

final categoryProvider = StateNotifierProvider<CategoryNotifier, List<Map<String, dynamic>>>((ref) {
      final dio = ref.watch(dioProvider);
      return CategoryNotifier(dio);
    });

final selectedCategoryProvider = StateProvider<String?>((ref) => null);
