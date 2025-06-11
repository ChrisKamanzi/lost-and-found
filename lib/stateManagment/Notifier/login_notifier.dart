import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends AsyncNotifier<void> {
  final Dio _dio = Dio();

  String get apiUrl {
    final url = dotenv.env['apiUrl'];
    if (url == null) throw Exception('API URL not set');
    return url;
  }

  @override
  FutureOr<void> build() {}


  Future<String?> login(String email, String password) async {
    state = AsyncLoading();
    try {
      final response = await _dio.post(
        '$apiUrl/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data['token'];
        final userId = response.data['user']['id'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('authToken', token);
        if (userId is int) {
          await prefs.setInt('userId', userId);
        } else if (userId is String) {
          await prefs.setString('userId', userId);
        }

        state = const AsyncData(null);
        return null; // no error
      } else {
        return 'Login failed';
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return 'Connection timeout. Please check your internet.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return 'Server took too long to respond.';
      } else if (e.type == DioExceptionType.badResponse) {
        return 'Failed to Log In';
      } else {
        return 'Unexpected network error.';
      }
    } catch (e) {
      return 'Unexpected error occurred.';
    }
  }
}
