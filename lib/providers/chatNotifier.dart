// conversation_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../models/chatModel.dart';

class ConversationNotifier extends StateNotifier<AsyncValue<Conversation>> {
  final int receiverId;
  final String itemId;
  final Dio _dio = Dio();

  ConversationNotifier({required this.receiverId, required this.itemId}) : super(const AsyncLoading()) {
    fetchConversation();
  }

  Future<void> fetchConversation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken') ?? '';
      _dio.options.headers = {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      };

      final response = await _dio.get('$apiUrl/conversation/$receiverId/$itemId');
      final conversation = Conversation.fromJson(response.data);
      state = AsyncData(conversation);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> sendMessage(String convId, String messageText) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken') ?? '';
      _dio.options.headers = {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      };

      await _dio.post(
        '$apiUrl/message',
        data: {'conversation_id': convId, 'message': messageText},
      );

      await fetchConversation();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final conversationProvider = StateNotifierProvider.autoDispose
    .family<ConversationNotifier, AsyncValue<Conversation>, (int, String)>((ref, args) {
  final (receiverId, itemId) = args;
  return ConversationNotifier(receiverId: receiverId, itemId: itemId);
});
