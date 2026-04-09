import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/constants/api_constants.dart';
import '../../domain/entities/conversation_entity.dart';

class MessageRemoteDatasource {
  final ApiClient _apiClient;

  MessageRemoteDatasource(this._apiClient);

  Future<ApiResponse<List<ConversationEntity>>> getConversations() async {
    return _apiClient.get<List<ConversationEntity>>(
      ApiConstants.conversations,
      fromJson: (data) {
        if (data is List) {
          return data.map((e) => _parseConversation(e as Map<String, dynamic>)).toList();
        }
        final items = data['items'] as List? ?? [];
        return items.map((e) => _parseConversation(e as Map<String, dynamic>)).toList();
      },
    );
  }

  Future<ApiResponse<List<MessageEntity>>> getMessages(String conversationId, {int page = 1}) async {
    return _apiClient.get<List<MessageEntity>>(
      '${ApiConstants.messages}$conversationId',
      queryParameters: {'page': page},
      fromJson: (data) {
        if (data is List) {
          return data.map((e) => _parseMessage(e as Map<String, dynamic>)).toList();
        }
        final items = data['items'] as List? ?? [];
        return items.map((e) => _parseMessage(e as Map<String, dynamic>)).toList();
      },
    );
  }

  Future<ApiResponse<MessageEntity>> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    return _apiClient.post<MessageEntity>(
      '${ApiConstants.sendMessage}$conversationId',
      data: {'content': content},
      fromJson: (data) => _parseMessage(data as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<ConversationEntity>> startConversation({
    required String userId,
    required String listingId,
    String? message,
  }) async {
    return _apiClient.post<ConversationEntity>(
      ApiConstants.conversations,
      data: {
        'userId': userId,
        'listingId': listingId,
        if (message != null) 'message': message,
      },
      fromJson: (data) => _parseConversation(data as Map<String, dynamic>),
    );
  }

  ConversationEntity _parseConversation(Map<String, dynamic> json) {
    final otherUser = json['otherUser'] as Map<String, dynamic>? ?? {};
    final listing = json['listing'] as Map<String, dynamic>? ?? {};
    final images = listing['images'] as List? ?? [];
    return ConversationEntity(
      id: json['id'] as String? ?? '',
      otherUserId: otherUser['id'] as String? ?? '',
      otherUserName: otherUser['name'] as String? ?? '',
      otherUserAvatar: otherUser['avatar'] as String?,
      lastMessage: json['lastMessage'] as String?,
      lastMessageAt: json['lastMessageAt'] != null
          ? DateTime.tryParse(json['lastMessageAt'].toString())
          : null,
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
      listingId: listing['id'] as String? ?? '',
      listingTitle: listing['title'] as String?,
      listingImage: images.isNotEmpty ? images[0].toString() : null,
    );
  }

  MessageEntity _parseMessage(Map<String, dynamic> json) {
    return MessageEntity(
      id: json['id'] as String? ?? '',
      conversationId: json['conversationId'] as String? ?? '',
      senderId: json['senderId'] as String? ?? '',
      content: json['content'] as String? ?? '',
      type: json['type'] as String? ?? 'text',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }
}
