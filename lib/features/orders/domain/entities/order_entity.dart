class OrderEntity {
  final String id;
  final String listingId;
  final String listingTitle;
  final String listingImage;
  final int price;
  final String buyerId;
  final String buyerName;
  final String sellerId;
  final String sellerName;
  final String status;
  final String? notes;
  final String? createdAt;
  final String? updatedAt;
  final String? completedAt;

  const OrderEntity({
    required this.id,
    required this.listingId,
    required this.listingTitle,
    required this.listingImage,
    required this.price,
    required this.buyerId,
    required this.buyerName,
    required this.sellerId,
    required this.sellerName,
    required this.status,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.completedAt,
  });

  String get statusDisplay {
    switch (status) {
      case 'pending': return 'Menunggu Pembayaran';
      case 'paid': return 'Sudah Dibayar';
      case 'processing': return 'Diproses';
      case 'shipped': return 'Dikirim';
      case 'completed': return 'Selesai';
      case 'cancelled': return 'Dibatalkan';
      case 'refunded': return 'Dikembalikan';
      default: return status;
    }
  }
}
