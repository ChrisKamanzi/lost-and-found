import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/api.dart';

Future<String> fetchName(String token) async {
  final Dio dio = Dio();

  try {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    final response = await dio.get('$apiUrl/user/details');

    if (response.statusCode == 200) {
      final data = response.data;
      final userDetails = data['user-details'];
      return userDetails['name'] ?? 'No Name';
    } else {
      throw Exception('Failed to load name');
    }
  } catch (e) {
    print('Error fetching name: $e');
    throw Exception('Failed to load name');
  }
}

Future<String> fetchEmail(String token) async {
  final Dio _dio = Dio();

  try {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    final response = await _dio.get('$apiUrl/user/details');

    if (response.statusCode == 200) {
      final data = response.data['user-details'];
      return data['email'];
    } else {
      throw Exception('Failed to load name');
    }
  } catch (e) {
    throw Exception('Failed to load name');
  }
}

Future<String> fetchPhone(String token) async {
  final Dio dio = Dio();

  try {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    final response = await dio.get('$apiUrl/user/details');
    if (response.statusCode == 200) {
      final data = response.data;
      final userDetails = data['user-details'];
      return userDetails['telephone'] ?? 'No telephone';
    } else {
      throw Exception('Failed to load name');
    }
  } catch (e) {
    throw Exception('Failed to load name');
  }
}

final nameeProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken') ?? '';
  if (token.isEmpty) throw Exception('No token found');
  return await fetchName(token);
});

final EmailProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken') ?? '';

  if (token.isEmpty) throw Exception('No token found');
  return await fetchEmail(token);
});

final phoneProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken') ?? '';

  if (token.isEmpty) throw Exception('No token found');
  return await fetchPhone(token);
});
