import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../service/chat_Notifier.dart';

class chat extends ConsumerStatefulWidget {
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
  _ChatState createState() => _ChatState();
}

class _ChatState extends ConsumerState<chat> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      chatProvider((userId: widget.userId, itemId: widget.itemId)),
    );
    final notifier = ref.read(
      chatProvider((userId: widget.userId, itemId: widget.itemId)).notifier,
    );

    final messages = state.messages ?? [];

    if (messages.isEmpty) {
      print('No messages available.');
    } else {
      print('Messages available: ${messages.length}');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: GoogleFonts.brawler(fontWeight: FontWeight.w800, fontSize: 28),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Icon(
                Icons.person,
                color: Colors.deepPurpleAccent.shade100,
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
                  // Log each message
                  print('Displaying message: $message');
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
                        style: const TextStyle(color: Colors.white),
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
                    child: const Icon(Icons.message, color: Colors.black45),
                  ),
                  const SizedBox(width: 5),
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
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      final text = _controller.text.trim();
                      // Log the message to be sent
                      print('Sending message: $text');
                      if (text.isNotEmpty) {
                        notifier.sendMessage(text);
                        _controller.clear();
                      } else {
                        print('Cannot send an empty message.');
                      }
                    },
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
