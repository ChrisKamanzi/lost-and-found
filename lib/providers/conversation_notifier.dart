import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/api.dart';
import '../models/conversation_model.dart';

class ChatHistoryNotifier extends StateNotifier<List<ChatHistory>?> {
  ChatHistoryNotifier() : super(null);
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
        print("Failed to fetch chat histories: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print('Error fetching chat histories: $e');
      return [];
    }


  }
}

