import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/conversationModel.dart';
import 'conversationNotifier.dart';

final chatHistoryProvider = StateNotifierProvider<ChatHistoryNotifier, List<ChatHistory>?>(
      (ref) => ChatHistoryNotifier(),
);