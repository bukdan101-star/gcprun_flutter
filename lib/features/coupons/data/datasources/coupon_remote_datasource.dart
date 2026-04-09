import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/constants/api_constants.dart';
import '../../domain/entities/coupon_entity.dart';

class CouponRemoteDatasource {
  final ApiClient _apiClient;

  CouponRemoteDatasource(this._apiClient);

  Future<ApiResponse<List<CouponEntity>>> getAvailableCoupons() async {
    return _apiClient.get<List<CouponEntity>>(
      ApiConstants.coupons,
      fromJson: (data) {
        if (data is List) {
          return data.map((e) => _parseCoupon(e as Map<String, dynamic>)).toList();
        }
        final items = data['items'] as List? ?? [];
        return items.map((e) => _parseCoupon(e as Map<String, dynamic>)).toList();
      },
    );
  }

  Future<ApiResponse<List<CouponEntity>>> getMyCoupons() async {
    return _apiClient.get<List<CouponEntity>>(
      ApiConstants.myCoupons,
      fromJson: (data) {
        if (data is List) {
          return data.map((e) => _parseCoupon(e as Map<String, dynamic>)).toList();
        }
        final items = data['items'] as List? ?? [];
        return items.map((e) => _parseCoupon(e as Map<String, dynamic>)).toList();
      },
    );
  }

  Future<ApiResponse<CouponEntity>> applyCoupon(String code) async {
    return _apiClient.post<CouponEntity>(
      ApiConstants.applyCoupon,
      data: {'code': code},
      fromJson: (data) => _parseCoupon(data as Map<String, dynamic>),
    );
  }

  CouponEntity _parseCoupon(Map<String, dynamic> json) {
    final validFrom = json['validFrom'] != null
        ? DateTime.tryParse(json['validFrom'].toString())
        : null;
    final validUntil = json['validUntil'] != null
        ? DateTime.tryParse(json['validUntil'].toString())
        : null;
    final now = DateTime.now();

    return CouponEntity(
      id: json['id'] as String? ?? '',
      code: json['code'] as String? ?? '',
      description: json['description'] as String? ?? '',
      discountAmount: (json['discountAmount'] as num?)?.toInt() ?? 0,
      minOrderAmount: (json['minOrderAmount'] as num?)?.toInt(),
      discountType: json['discountType'] as String? ?? 'percentage',
      validFrom: validFrom,
      validUntil: validUntil,
      usageLimit: (json['usageLimit'] as num?)?.toInt() ?? 0,
      usedCount: (json['usedCount'] as num?)?.toInt() ?? 0,
      isUsed: json['isUsed'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      isExpired: validUntil != null && now.isAfter(validUntil),
    );
  }
}
