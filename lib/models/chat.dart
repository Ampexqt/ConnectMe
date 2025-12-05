/// Chat Message Model
/// Represents a single message in a conversation
class ChatMessage {
  final String id;
  final String message;
  final String timestamp;
  final bool sent;

  ChatMessage({
    required this.id,
    required this.message,
    required this.timestamp,
    required this.sent,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      message: json['message'] as String,
      timestamp: json['timestamp'] as String,
      sent: json['sent'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'message': message, 'timestamp': timestamp, 'sent': sent};
  }
}

/// Chat Conversation Model
/// Represents a conversation with another user
class ChatConversation {
  final String userId;
  final String name;
  final String avatar;
  final String lastMessage;
  final String timestamp;
  final int unread;
  final bool online;
  final List<ChatMessage> messages;

  ChatConversation({
    required this.userId,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.timestamp,
    required this.unread,
    required this.online,
    required this.messages,
  });

  factory ChatConversation.fromJson(Map<String, dynamic> json) {
    return ChatConversation(
      userId: json['userId'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      lastMessage: json['lastMessage'] as String,
      timestamp: json['timestamp'] as String,
      unread: json['unread'] as int,
      online: json['online'] as bool,
      messages: (json['messages'] as List)
          .map((m) => ChatMessage.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'avatar': avatar,
      'lastMessage': lastMessage,
      'timestamp': timestamp,
      'unread': unread,
      'online': online,
      'messages': messages.map((m) => m.toJson()).toList(),
    };
  }
}
