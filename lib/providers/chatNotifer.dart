import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/api.dart';
import '../models/chatModel.dart';

class ConversationNotifier extends StateNotifier<AsyncValue<Conversation>> {
  ConversationNotifier() : super(const AsyncLoading());

  final Dio _dio = Dio();

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
        throw Exception('Failed to send message');
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}