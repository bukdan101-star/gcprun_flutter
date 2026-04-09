import '../entities/conversation_entity.dart';

abstract class MessageRepository {
  Future<List<ConversationEntity>> getConversations();
  Future<List<MessageEntity>> getMessages(String conversationId, {int page = 1});
  Future<MessageEntity> sendMessage({required String conversationId, required String content});
  Future<ConversationEntity> startConversation({required String userId, required String listingId, String? message});
}
