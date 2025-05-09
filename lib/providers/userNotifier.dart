import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/models/emailModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EmailNotifier extends StateNotifier<Account?> {
  EmailNotifier() : super(null);

  Future<void> fetchEmail() async {
    Dio _dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    final token2 = prefs.getString('authToken');

    try {
      final response = await _dio.get(
        '$apiUrl/user/details',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token2',
          },
        ),
      );

      if (response.statusCode == 200) {
        final account = Account.fromJson(response.data); // assumes proper model
        state = account;
      } else {
        print('Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user details: $e');
      throw Exception('Failed to load user details');
    }
  }
}
