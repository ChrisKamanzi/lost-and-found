import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lost_and_found/constant/api.dart';

class Message {
  final String messageId;
  final String message;
  final String sender;
  final String messagedAt;
  final String? readAt;

  Message({
    required this.messageId,
    required this.message,
    required this.sender,
    required this.messagedAt,
    this.readAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['message_id'],
      message: json['message'],
      sender: json['sender'],
      messagedAt: json['messaged_at'],
      readAt: json['read_at'],
    );
  }
}

class Conversation {
  final String receiver;
  final String convId;
  final List<Message> messages;

  Conversation({
    required this.receiver,
    required this.convId,
    required this.messages,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    var messagesList = json['messages'] as List;
    List<Message> messages =
        messagesList.map((msg) => Message.fromJson(msg)).toList();

    return Conversation(
      receiver: json['receiver'],
      convId: json['conv_id'],
      messages: messages,
    );
  }
}

Future<Conversation> fetchConversation(String receiverId, String itemId) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');

  print('[SharedPreferences] Retrieved token: $token');
  if (token == null) {
    throw Exception('Token not found in local storage');
  }

  final Dio dio = Dio();
  dio.options.headers = {
    'Authorization': 'Bearer $token',
    'accept': 'application/json',
  };

  final url = '$apiUrl/conversation/$receiverId/$itemId';

  try {
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final data = response.data;
      return Conversation.fromJson(data);
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token.');
    } else {
      throw Exception('Failed to fetch conversation: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error fetching conversation: $error');
  }
}
