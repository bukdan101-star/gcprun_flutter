class CouponEntity {
  final String id;
  final String code;
  final String description;
  final int discountAmount;
  final int? minOrderAmount;
  final String discountType;
  final DateTime? validFrom;
  final DateTime? validUntil;
  final int usageLimit;
  final int usedCount;
  final bool isUsed;
  final bool isActive;
  final bool isExpired;

  const CouponEntity({
    required this.id,
    required this.code,
    required this.description,
    required this.discountAmount,
    this.minOrderAmount,
    required this.discountType,
    this.validFrom,
    this.validUntil,
    this.usageLimit = 0,
    this.usedCount = 0,
    this.isUsed = false,
    this.isActive = true,
    this.isExpired = false,
  });
}
