import '../../domain/entities/listing_entity.dart';

class ListingModel {
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

  const ListingModel({
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

  factory ListingModel.fromJson(Map<String, dynamic> json) {
    return ListingModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      condition: json['condition'] as String? ?? 'baru',
      category: json['category'] as String? ?? '',
      location: json['location'] as String?,
      images: (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      sellerId: json['sellerId'] as String? ?? '',
      sellerName: json['sellerName'] as String? ?? '',
      sellerAvatar: json['sellerAvatar'] as String?,
      isNegotiable: json['isNegotiable'] as bool? ?? true,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      wishlistCount: (json['wishlistCount'] as num?)?.toInt() ?? 0,
      isWishlisted: json['isWishlisted'] as bool? ?? false,
      status: json['status'] as String? ?? 'active',
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  ListingEntity toEntity() {
    return ListingEntity(
      id: id,
      title: title,
      description: description,
      price: price,
      condition: condition,
      category: category,
      location: location,
      images: images,
      sellerId: sellerId,
      sellerName: sellerName,
      sellerAvatar: sellerAvatar,
      isNegotiable: isNegotiable,
      viewCount: viewCount,
      wishlistCount: wishlistCount,
      isWishlisted: isWishlisted,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
