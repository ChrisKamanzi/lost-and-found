import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/constant/api.dart';  // Ensure apiUrl is correctly defined
import 'package:shared_preferences/shared_preferences.dart';
import 'chat.dart';

class ChatState {
  final List<String> messages;
  final String? conversationId;

  ChatState({this.messages = const [], this.conversationId});

  ChatState copyWith({List<String>? messages, String? conversationId}) {
    return ChatState(
      messages: messages ?? this.messages,
      conversationId: conversationId ?? this.conversationId,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  final ChatRepository repository;
  final int userId;
  final String itemId;

  ChatNotifier(this.repository, this.userId, this.itemId)
      : super(ChatState()) {
    fetchConversationId();
  }

  Future<void> fetchConversationId() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token == null) {
      print('Token missing!');
      return;
    }

    final dio = Dio();
    try {
      final url = '$apiUrl/conversation/$userId/$itemId';

      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final convId = response.data['conversationId'];
        if (convId != null) {
          state = state.copyWith(conversationId: convId);
        }
      } else {
        print('Failed to fetch conversation ID: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching conversation ID: $e');
    }
  }

  Future<void> fetchConversationById() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      print('Token missing!');
      return;
    }

    try {
      final url = '$apiUrl/conversation/$userId/$itemId';

      final response = await Dio().get(
        url,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        final convId = response.data['conversationId'];
        if (convId != null) {
          state = state.copyWith(conversationId: convId);
          await fetchMessages(convId); // Fetch messages here
        }
      } else {
        print('Failed to fetch conversation ID: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching conversation ID: $e');
    }
  }

  Future<void> fetchMessages(String convId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      print('Token missing!');
      return;
    }

    try {
      final response = await Dio().get(
        '$apiUrl/conversation/$convId/messages',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        final List<String> messages = (response.data['messages'] as List)
            .map((message) => message['content'].toString())
            .toList();
        state = state.copyWith(messages: messages);
      } else {
        print('Failed to fetch messages: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }


  Future<void> sendMessage(String message) async {
    if (state.conversationId == null || message.trim().isEmpty) return;

    state = state.copyWith(messages: [...state.messages, message]);

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      print('Token missing!');
      return;
    }

    final dio = Dio();
    try {
      await dio.post(
        '$apiUrl/message',
        data: {
          'Conversation_id': userId,
          'itemId': itemId,
          'message': message,
        },

        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
    } on DioException catch (e) {
      print('Error sending message: $e');
    }
  }
}

final chatProvider = StateNotifierProvider.family<ChatNotifier, ChatState,
    ({int userId, String itemId})>((ref, args) {
  final repo = ref.watch(chatRepositoryProvider);
  return ChatNotifier(repo, args.userId, args.itemId);
});
