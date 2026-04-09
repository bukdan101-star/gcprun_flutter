import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/constants/api_constants.dart';
import '../../domain/entities/support_ticket_entity.dart';

class SupportRemoteDatasource {
  final ApiClient _apiClient;

  SupportRemoteDatasource(this._apiClient);

  Future<ApiResponse<List<SupportTicketEntity>>> getTickets({int page = 1}) async {
    return _apiClient.get<List<SupportTicketEntity>>(
      ApiConstants.supportTickets,
      queryParameters: {'page': page},
      fromJson: (data) {
        if (data is List) {
          return data.map((e) => _parseTicket(e as Map<String, dynamic>)).toList();
        }
        final items = data['items'] as List? ?? [];
        return items.map((e) => _parseTicket(e as Map<String, dynamic>)).toList();
      },
    );
  }

  Future<ApiResponse<SupportTicketEntity>> getTicketDetail(String id) async {
    return _apiClient.get<SupportTicketEntity>(
      '${ApiConstants.ticketMessages}$id',
      fromJson: (data) => _parseTicket(data as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<SupportTicketEntity>> createTicket({
    required String subject,
    required String category,
    required String message,
  }) async {
    return _apiClient.post<SupportTicketEntity>(
      ApiConstants.createTicket,
      data: {'subject': subject, 'category': category, 'message': message},
      fromJson: (data) => _parseTicket(data as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<TicketMessageEntity>> replyToTicket({
    required String ticketId,
    required String content,
  }) async {
    return _apiClient.post<TicketMessageEntity>(
      '${ApiConstants.ticketMessages}$ticketId/reply',
      data: {'content': content},
      fromJson: (data) => _parseMessage(data as Map<String, dynamic>),
    );
  }

  SupportTicketEntity _parseTicket(Map<String, dynamic> json) {
    final messagesJson = json['messages'] as List? ?? [];
    return SupportTicketEntity(
      id: json['id'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      category: json['category'] as String? ?? 'general',
      status: json['status'] as String? ?? 'open',
      lastMessage: json['lastMessage'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      messages: messagesJson.map((e) => _parseMessage(e as Map<String, dynamic>)).toList(),
    );
  }

  TicketMessageEntity _parseMessage(Map<String, dynamic> json) {
    return TicketMessageEntity(
      id: json['id'] as String? ?? '',
      ticketId: json['ticketId'] as String? ?? '',
      content: json['content'] as String? ?? '',
      isFromAdmin: json['isFromAdmin'] as bool? ?? false,
      attachmentUrl: json['attachmentUrl'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }
}
