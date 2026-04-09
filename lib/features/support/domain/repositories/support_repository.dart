import '../entities/support_ticket_entity.dart';

abstract class SupportRepository {
  Future<List<SupportTicketEntity>> getTickets({int page = 1});
  Future<SupportTicketEntity> getTicketDetail(String id);
  Future<SupportTicketEntity> createTicket({required String subject, required String category, required String message});
  Future<TicketMessageEntity> replyToTicket({required String ticketId, required String content});
}
