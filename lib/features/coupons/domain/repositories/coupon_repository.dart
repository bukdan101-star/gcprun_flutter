import '../entities/coupon_entity.dart';

abstract class CouponRepository {
  Future<List<CouponEntity>> getAvailableCoupons();
  Future<List<CouponEntity>> getMyCoupons();
  Future<CouponEntity> applyCoupon(String code);
}
