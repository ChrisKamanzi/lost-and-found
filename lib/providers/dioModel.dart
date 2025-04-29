import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/constant/api.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = '$apiUrl';
  dio.options.headers['Content-Type'] = 'application/json';
  return dio;
});
