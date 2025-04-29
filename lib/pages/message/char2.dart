import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/chatModel.dart';

class ConversationScreen extends StatefulWidget {
  final String? conv_id;
  final int receiverId;
  final String itemId;
  final String? name;

  const ConversationScreen({
    Key? key,
    required this.receiverId,
    required this.itemId,
    this.conv_id,
    this.name,
  }) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late Future<Conversation> _conversationFuture;
  final TextEditingController _messageController = TextEditingController();
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _conversationFuture = fetchConversation();
  }

  Future<Conversation> fetchConversation() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      throw Exception('Token not found');
    }

    _dio.options.headers = {
      'Authorization': 'Bearer $token',
      'accept': 'application/json',
    };

    final url = '$apiUrl/conversation/${widget.receiverId}/${widget.itemId}';
    final response = await _dio.get(url);

    if (response.statusCode == 200) {
      final data = response.data;
      return Conversation.fromJson(data);
    } else {
      throw Exception('Failed to fetch conversation');
    }
  }

  Future<void> sendMessage(String convId, String messageText) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      throw Exception('Token not found');
    }

    _dio.options.headers = {
      'Authorization': 'Bearer $token',
      'accept': 'application/json',
    };

    final url = '$apiUrl/message';

    print('[Sending Message] conversation_id: $convId, message: $messageText');

    try {
      final response = await _dio.post(
        url,
        data: {'conversation_id': convId, 'message': messageText},
      );

      print('[Response status code] ${response.statusCode}');
      print('[Response data] ${response.data}');

      if (response.statusCode == 200) {
        print('Message sent successfully');
        setState(() {
          _conversationFuture = fetchConversation();
          _messageController.clear();
        });
      } else {
        print('Failed with status: ${response.statusCode}');
        print('Response data: ${response.data}');
        throw Exception('Failed to send message');
      }
    } catch (error) {
      print('Error sending message: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name ?? 'Chat',
          style: GoogleFonts.brawler(
            textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
          ),
        ),
      ),

      body: FutureBuilder<Conversation>(
        future: _conversationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final conversation = snapshot.data!;
            final messages = conversation.messages;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[messages.length - 1 - index];
                      return ListTile(
                        title: Text(message.sender),
                        subtitle: Text(message.message),
                        trailing: Text(
                          message.messagedAt,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 50,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          final messageText = _messageController.text.trim();
                          if (messageText.isNotEmpty) {
                            sendMessage(conversation.convId, messageText);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No messages.'));
          }
        },
      ),
    );
  }
}
