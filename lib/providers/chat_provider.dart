import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/chat_model.dart';
import 'chat_notifer.dart';

final conversationProvider = StateNotifierProvider.autoDispose
    .family<ConversationNotifier, AsyncValue<Conversation>, (int, String)>(
      (ref, tuple) => ConversationNotifier()..loadConversation(tuple.$1, tuple.$2),
);
