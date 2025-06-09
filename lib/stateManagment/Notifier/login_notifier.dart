import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends AsyncNotifier<void> {
  final Dio _dio = Dio();

  @override
  FutureOr<void> build() {}

  Future<void> login(String email, String password) async {
    state =  AsyncLoading();
    try {
      final response = await _dio.post('$apiUrl/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data['token'];
        final userId = response.data['user']['id'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        await prefs.setInt('userId', userId);

        state = const AsyncData(null);
      } else {
        throw Exception('Login failed');
      }
    } on DioException catch (e) {
      state = AsyncError(
        e.response?.data['message'] ??
            'Something went wrong. Please try again.',
        StackTrace.current,
      );
    } catch (e) {
      state = AsyncError('Unexpected error occurred.', StackTrace.current);
    }
  }
}
