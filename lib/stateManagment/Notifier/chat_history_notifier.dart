import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/conversation_model.dart';

class ChatHistoryNotifier extends StateNotifier<List<ChatHistory>?> {
  ChatHistoryNotifier() : super(null);

  String? errorMessage;


  String get apiUrl {
    final url = dotenv.env['apiUrl'];
    if (url == null) throw Exception('API URL not set');
    return url;
  }

  Future<List<ChatHistory>> fetchChatHistories() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    try {
      final response = await Dio().get(
        '$apiUrl/conversations',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data['conversations'] as List;
        final chatHistories = data.map((e) => ChatHistory.fromJson(e)).toList();
        state = chatHistories;
        return chatHistories;
      } else {
        return [];
      }
    } catch (e) {
      if (e is DioError) {
        errorMessage =
            e.response?.data['message'] ??
            'Something went wrong. Please try again.';
      } else {
        errorMessage = 'An unexpected error occurred.';
      }
      return [];
    }
  }
}
