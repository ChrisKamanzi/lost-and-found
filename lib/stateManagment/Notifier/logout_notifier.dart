import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutNotifier extends StateNotifier<AsyncValue<void>> {
  LogoutNotifier() : super(const AsyncData(null));

  String? errorMessage;

  Future<void> logout() async {
    state = const AsyncLoading();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token != null) {
        final dio = Dio();
        final response = await dio.post(
          '$apiUrl/logout',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
          ),
        );
        if (response.statusCode == 200) {
          await prefs.clear();
          state = const AsyncData(null);
        } else {
          state = AsyncError('Logout failed on server.', StackTrace.current);
        }
      } else {
        await prefs.remove('authToken');
        await prefs.remove('isLoggedIn');
        await prefs.remove('userId');

        state = const AsyncData(null);
      }
    } catch (e, st) {
      if (e is DioError) {
        errorMessage =
            e.response?.data['message'] ??
            'Something went wrong. Please try again.';
      } else {
        errorMessage = 'An unexpected error occurred.';
      }
      state = AsyncError(e, st);
    }
  }
}
