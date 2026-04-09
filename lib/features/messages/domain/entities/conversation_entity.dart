class ConversationEntity {
  final String id;
  final String otherUserId;
  final String otherUserName;
  final String? otherUserAvatar;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final String listingId;
  final String? listingTitle;
  final String? listingImage;

  const ConversationEntity({
    required this.id,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserAvatar,
    this.lastMessage,
    this.lastMessageAt,
    this.unreadCount = 0,
    required this.listingId,
    this.listingTitle,
    this.listingImage,
  });
}

class MessageEntity {
  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final String type;
  final DateTime? createdAt;
  final bool isMine;

  const MessageEntity({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    this.type = 'text',
    this.createdAt,
    this.isMine = false,
  });
}
