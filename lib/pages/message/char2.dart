import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/chat_provider.dart';

class ConversationScreen extends ConsumerWidget {

  final int receiverId;
  final String itemId;
  final String? name;

  const ConversationScreen({
    super.key,
    required this.receiverId,
    required this.itemId,
    this.name,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final conversationAsync = ref.watch(conversationProvider((receiverId, itemId)));
    final notifier = ref.read(conversationProvider((receiverId, itemId)).notifier);
    final messageController = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: Text(
          name ?? 'Chat',
          style: GoogleFonts.brawler(
            textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
          ),
        ),
      ),
      body: conversationAsync.when(
        loading: () =>  Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (conversation) {
          final messages = conversation.messages;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {

                    final msg = messages[messages.length - 1 - index];
                    final isMe = msg.sender == receiverId ? false : true;

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin:  EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding:  EdgeInsets.all(12),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.green[300] : Colors.blue[300],
                          borderRadius: BorderRadius.only(
                            topLeft:  Radius.circular(12),
                            topRight:Radius.circular(12),
                            bottomLeft: Radius.circular(isMe ? 12 : 0),
                            bottomRight: Radius.circular(isMe ? 0 : 12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              msg.message,
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          SizedBox(height: 5),
                            Text(
                              msg.messagedAt,
                              style: TextStyle(color: Colors.white70, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    );
                    },
                ),
              ),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration:  InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        final text = messageController.text.trim();
                        if (text.isNotEmpty) {
                          notifier.sendMessage(conversation.convId, text, receiverId, itemId);
                          messageController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
