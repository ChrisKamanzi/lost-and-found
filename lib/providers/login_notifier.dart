import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends StateNotifier<LoginModel> {
  LoginNotifier() : super(LoginModel(email: '', password: ''));

  final Dio _dio = Dio();

  Future<void> login(String email, String password) async {
    try {
      state = LoginModel(email: email, password: password);
      final response = await _dio.post(
        '$apiUrl/login',
        data: state.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data['token'];
        final userId = response.data['user']['id'];


        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        await prefs.setInt('userId', userId);

        print('Login successful: token saved');
      } else {
        print('Login failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Login error: ${e.response?.data ?? e.message}');
    }
  }
}
