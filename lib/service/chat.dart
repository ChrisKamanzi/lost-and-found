import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/UserMessage.dart';
import '../providers/dioModel.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ChatRepository(dio);
});

class ChatRepository {
  final Dio dio;

  ChatRepository(this.dio);

  Future<String?> fetchConversation(int receiverUserId, String itemId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    print('Fetched token: $token');
    print(
      'Fetching conversation with receiverUserId: $receiverUserId and itemId: $itemId',
    );

    if (token == null) {
      print('No token found. User might not be logged in.');
      return null;
    }

    try {
      final response = await dio.get(
        '/conversation/$receiverUserId/$itemId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      print('Response data: ${response.data}');
      return response.data['conv_id']?.toString();
    } catch (e) {
      print('Error fetching conversation: $e');
      return null;
    }
  }

  Future<List<Message>> fetchMessages(String conversationId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      print('No token found. User might not be logged in.');
      return [];
    }

    try {
      final response = await dio.get(
        '/api/v1/conversation/$conversationId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final List data = response.data['messages'];
      return data.map((e) => Message.fromJson(e)).toList();
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }

  Future<bool> sendMessage(String convId, String message) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      print('No token found. User might not be logged in.');
      return false;
    }

    try {
      await dio.post(
        '/message',
        data: {'conversation_id': convId, 'message': message},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return true;
    } catch (e) {
      print('Error sending message: $e');
      return false;
    }
  }
}
