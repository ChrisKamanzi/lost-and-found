import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/models/reset_password.dart';
import 'package:go_router/go_router.dart';

import '../constant/api.dart';

class ResetNotifier extends StateNotifier<ResetPasswordModel> {
  ResetNotifier(super.state);

  Future<void> _forgotPassword(
    ResetPasswordModel model,
    BuildContext context,
  ) async {
    String loginUrl = "$apiUrl/forgot-password";
    Dio dio = Dio();

    try {
      final response = await dio.post(loginUrl, data: model.toJson());

      print('Response body: ${response.data}');
      if (response.statusCode == 200) {
        final data = response.data;
        print('Success: $data');
        context.go('/token');
      } else {
        print('Forgot password failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
