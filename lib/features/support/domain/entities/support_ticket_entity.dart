class SupportTicketEntity {
  final String id;
  final String subject;
  final String category;
  final String status;
  final String? lastMessage;
  final String? createdAt;
  final String? updatedAt;
  final List<TicketMessageEntity> messages;

  const SupportTicketEntity({
    required this.id,
    required this.subject,
    required this.category,
    required this.status,
    this.lastMessage,
    this.createdAt,
    this.updatedAt,
    this.messages = const [],
  });

  String get statusDisplay {
    switch (status) {
      case 'open': return 'Terbuka';
      case 'in_progress': return 'Diproses';
      case 'waiting': return 'Menunggu Balasan';
      case 'resolved': return 'Terselesaikan';
      case 'closed': return 'Ditutup';
      default: return status;
    }
  }
}

class TicketMessageEntity {
  final String id;
  final String ticketId;
  final String content;
  final bool isFromAdmin;
  final String? attachmentUrl;
  final String? createdAt;

  const TicketMessageEntity({
    required this.id,
    required this.ticketId,
    required this.content,
    this.isFromAdmin = false,
    this.attachmentUrl,
    this.createdAt,
  });
}
