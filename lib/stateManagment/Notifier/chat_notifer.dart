import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/chat_model.dart';

class ConversationNotifier extends StateNotifier<AsyncValue<Conversation>> {
  ConversationNotifier() : super(const AsyncLoading());

  final Dio _dio = Dio();
  String? errorMessage;



  String get apiUrl {
    final url = dotenv.env['apiUrl'];
    if (url == null) throw Exception('API URL not set');
    return url;
  }

  Future<void> loadConversation(int receiverId, String itemId) async {
    state = const AsyncLoading();
    try {

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      if (token == null) throw Exception('Token not found');

      _dio.options.headers = {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      };

      final response = await _dio.get(
          '$apiUrl/conversation/$receiverId/$itemId');
      final data = response.data;

      state = AsyncData(Conversation.fromJson(data));
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

  Future<void> sendMessage(String convId, String messageText, int receiverId,
      String itemId) async {
    try {

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      if (token == null) throw Exception('Token not found');

      _dio.options.headers = {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      };

      final newMessage = Message(
        messageId: UniqueKey().toString(),
        message: messageText,
        sender: 'You',
        messagedAt: DateTime.now().toIso8601String(),
        readAt: null,
      );

      if (state is AsyncData<Conversation>) {
        final current = (state as AsyncData<Conversation>).value;
        final updatedMessages = [...current.messages, newMessage];

        final updatedConversation = Conversation(
          receiver: current.receiver,
          convId: current.convId,
          messages: updatedMessages,
        );

        state = AsyncData(updatedConversation);
      }

      final response = await _dio.post(
        '$apiUrl/message',
        data: {'conversation_id': convId, 'message': messageText},
      );
      if (response.statusCode == 200) {
        await loadConversation(receiverId, itemId);
      } else {
        print('error');
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
