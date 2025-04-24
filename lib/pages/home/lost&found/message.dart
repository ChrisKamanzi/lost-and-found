import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/api.dart';

class chat extends StatefulWidget {
  final String itemId;
  final int userId;
  final String name;

  const chat({
    super.key,
    required this.itemId,
    required this.userId,
    required this.name,
  });

  @override
  State<chat> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<chat> {
  final TextEditingController _controller = TextEditingController();
  final List<String> messages = [];
  String? conversationId;

  @override
  void initState() {
    super.initState();
    fetchConversation();
  }

  void _sendMessage() async {
    final messageText = _controller.text.trim();
    if (messageText.isEmpty || conversationId == null) return;

    setState(() {
      messages.add(messageText);
    });
    _controller.clear();

    await sendMessageToApi(messageText);
  }

  Future<void> fetchConversation() async {
    final url = Uri.parse(
      '$apiUrl/conversation/${widget.userId}/${widget.itemId}',
    );
    print('${widget.userId} , ${widget.itemId}');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('Conversation data: $data');
        setState(() {
          conversationId = data['conv_id']?.toString();
        });
      } else {
        print('Failed to load conversation: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching conversation: $e');
    }
  }

  Future<void> sendMessageToApi(String message) async {
    if (conversationId == null) return;
    final url = Uri.parse('$apiUrl/message');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'conversation_id': conversationId,
        //  'user_id': widget.userId,
          'message': message,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Message sent successfully');
      } else {
        print('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: GoogleFonts.brawler(
            textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.person,
                color: Colors.deepPurpleAccent.shade100,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[messages.length - 1 - index];
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade500,
                        borderRadius: BorderRadius.circular(36),
                      ),
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              color: Colors.grey[100],
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade300,
                    ),
                    child: Icon(Icons.message, color: Colors.black45),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Start typing here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                    color: Colors.deepPurple.shade500,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
