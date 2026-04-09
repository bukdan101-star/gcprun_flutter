import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getMyOrders({String? status, int page = 1});
  Future<List<OrderEntity>> getSellerOrders({String? status, int page = 1});
  Future<OrderEntity?> getOrderById(String id);
  Future<OrderEntity> createOrder({required String listingId, String? notes});
  Future<void> cancelOrder(String id);
  Future<void> confirmOrder(String id);
  Future<void> completeOrder(String id);
}
