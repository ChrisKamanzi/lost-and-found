import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/chatModel.dart';
import '../../constant/api.dart';

final conversationProvider = StateNotifierProvider.autoDispose
    .family<ConversationNotifier, AsyncValue<Conversation>, ConversationParams>(
      (ref, params) => ConversationNotifier(params),
);

class ConversationParams {
  final int receiverId;
  final String itemId;

  ConversationParams({required this.receiverId, required this.itemId});
}
class ConversationNotifier extends StateNotifier<AsyncValue<Conversation>> {
  final Dio _dio = Dio();
  final ConversationParams params;

  ConversationNotifier(this.params) : super(const AsyncLoading()) {
    fetchConversation();
  }

  Future<void> fetchConversation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      if (token == null) throw Exception('Token not found');

      _dio.options.headers = {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      };

      final url = '$apiUrl/conversation/${params.receiverId}/${params.itemId}';
      final response = await _dio.get(url);

      if (!mounted) return; // ✅ check before setting state

      if (response.statusCode == 200) {
        state = AsyncValue.data(Conversation.fromJson(response.data));
      } else {
        state = AsyncValue.error('Failed to fetch conversation', StackTrace.current);
      }
    } catch (e, st) {
      if (!mounted) return;
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> sendMessage(String convId, String messageText) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      if (token == null) throw Exception('Token not found');

      _dio.options.headers = {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      };

      final url = '$apiUrl/message';
      final response = await _dio.post(
        url,
        data: {'conversation_id': convId, 'message': messageText},
      );

      if (!mounted) return; // ✅ double check here as well

      if (response.statusCode == 200) {
        await fetchConversation(); // refetch after sending message
      } else {
        throw Exception('Failed to send message');
      }
    } catch (e, st) {
      if (!mounted) return;
      state = AsyncValue.error(e, st);
    }
  }
}

