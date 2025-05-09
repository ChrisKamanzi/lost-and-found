
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





