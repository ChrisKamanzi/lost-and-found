import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import '../../models/sign_up_model.dart';

class SignUpNotifier extends StateNotifier<SignUpModel> {
  SignUpNotifier() : super(SignUpModel());

  final formKey = GlobalKey<FormState>();

  String get apiUrl {
    final url = dotenv.env['apiUrl'];
    if (url == null) throw Exception('API URL not set');
    return url;
  }
  void updateField({
    String? name,
    String? email,
    String? password,
    String? passwordConfirmation,
    String? phone,
    String? village,
  }) {
    state = SignUpModel(
      name: name ?? state.name,
      email: email ?? state.email,
      password: password ?? state.password,
      passwordConfirmation: passwordConfirmation ?? state.passwordConfirmation,
      phone: phone ?? state.phone,
      village: village ?? state.village,
    );
  }

  Future<void> signUp(BuildContext context, WidgetRef ref) async {
    final data = state;

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (data.password != data.passwordConfirmation) {
      showSnackBar(context, 'Passwords do not match.');
      return;
    }

    ref.read(loadingProvider.notifier).state = true;

    try {
      final response = await Dio().post(
        "$apiUrl/register",
        data: data.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        context.go('/congrat');
      } else if (response.statusCode == 422) {
        final errors = response.data['errors'];
        final firstErrorKey = errors.keys.first;
        final firstErrorMsg = errors[firstErrorKey][0];
        showSnackBar(context, firstErrorMsg);
      } else {
        showSnackBar(context, 'Error: ${response.statusMessage}');
      }
    } catch (e) {
      showSnackBar(context, 'Something went wrong: $e');
    } finally {
      ref.read(loadingProvider.notifier).state = false;
    }
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}


final loadingProvider = StateProvider<bool>((ref) => false);

