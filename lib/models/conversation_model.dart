class Receiver {
  final int id;
  final String name;

  Receiver({required this.id, required this.name});

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(id: json['id'], name: json['name']);
  }
}

class ChatHistory {
  final String convId;
  final Receiver  receiver;
  final String? itemId;
  final String? latestMessage;
  final int? unreadCount;
  final String? updatedAt;

  ChatHistory({
    required this.convId,
   required this.receiver,
    this.itemId,
    this.latestMessage,
    this.unreadCount,
    this.updatedAt,
  });

  factory ChatHistory.fromJson(Map<String, dynamic> json) {
    return ChatHistory(
      convId: json['conv_id'],
      receiver: Receiver.fromJson(json['receiver']),
      itemId: json['item_id'],
      latestMessage: json['latest_message'],
      unreadCount: json['unread_count'],
      updatedAt: json['updated_at'],
    );
  }
}
