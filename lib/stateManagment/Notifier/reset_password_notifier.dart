import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/reset_password.dart';
import 'package:go_router/go_router.dart';
import '../../constant/api.dart';

class ResetNotifier extends StateNotifier<ResetPasswordModel> {
  ResetNotifier()
      : super(ResetPasswordModel(
    token: null,
    email: null,
    password: null,
    passwordConfirmation: null,
  ));

  void updateEmail(String value) {
    state = ResetPasswordModel(
      token: state.token,
      email: value,
      password: state.password,
      passwordConfirmation: state.passwordConfirmation,
    );
  }

  void updateToken(String value) {
    state = ResetPasswordModel(
      token: value,
      email: state.email,
      password: state.password,
      passwordConfirmation: state.passwordConfirmation,
    );
  }

  void updatePassword(String value) {
    state = ResetPasswordModel(
      token: state.token,
      email: state.email,
      password: value,
      passwordConfirmation: state.passwordConfirmation,
    );
  }

  void updatePasswordConfirmation(String value) {
    state = ResetPasswordModel(
      token: state.token,
      email: state.email,
      password: state.password,
      passwordConfirmation: value,
    );
  }

  Future<void> resetPassword(BuildContext context) async {
    final url = "$apiUrl/reset-password";
    final dio = Dio();

    try {
      final response = await dio.post(url, data: state.toJson());

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successfully!')),
        );
        context.go('/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reset failed. Please try again.')),
        );
      }
    } catch (e) {
      print('Reset error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred.')),
      );
    }
  }
}


