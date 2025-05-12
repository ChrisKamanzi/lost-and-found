import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/chatScreenProvider.dart';

class ChatHistoryScreen extends ConsumerWidget {
  const ChatHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatHistories = ref.watch(chatHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('CHAT')),
      body: chatHistories == null

              ? const Center(child: CircularProgressIndicator())
              : chatHistories.isEmpty
              ? const Center(child: Text('No chat histories found.'))
              : ListView.builder(
                itemCount: chatHistories.length,
                itemBuilder: (context, index) {
                  final chatHistory = chatHistories[index];
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(chatHistory.receiver.name),
                    subtitle: Text(chatHistory.latestMessage),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          chatHistory.updatedAt,
                          style: const TextStyle(fontSize: 12),
                        ),
                        if (chatHistory.unreadCount > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Text(
                                chatHistory.unreadCount.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {

                    },
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(chatHistoryProvider.notifier).fetchChatHistories();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
