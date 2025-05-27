import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/conversation_model.dart';
import '../Notifier/chat_history_notifier.dart';

final chatHistoryProvider = StateNotifierProvider<ChatHistoryNotifier, List<ChatHistory>?>(
      (ref) => ChatHistoryNotifier(),
);