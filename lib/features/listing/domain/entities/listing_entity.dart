class ListingEntity {
  final String id;
  final String title;
  final String description;
  final int price;
  final String condition;
  final String category;
  final String? location;
  final List<String> images;
  final String sellerId;
  final String sellerName;
  final String? sellerAvatar;
  final bool isNegotiable;
  final int viewCount;
  final int wishlistCount;
  final bool isWishlisted;
  final String status;
  final String? createdAt;
  final String? updatedAt;

  const ListingEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.condition,
    required this.category,
    this.location,
    this.images = const [],
    required this.sellerId,
    required this.sellerName,
    this.sellerAvatar,
    this.isNegotiable = true,
    this.viewCount = 0,
    this.wishlistCount = 0,
    this.isWishlisted = false,
    this.status = 'active',
    this.createdAt,
    this.updatedAt,
  });
}
