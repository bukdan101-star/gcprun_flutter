import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/constants/api_constants.dart';
import '../../domain/entities/order_entity.dart';

class OrderRemoteDatasource {
  final ApiClient _apiClient;

  OrderRemoteDatasource(this._apiClient);

  Future<ApiResponse<List<OrderEntity>>> getMyOrders({String? status, int page = 1}) async {
    return _apiClient.get<List<OrderEntity>>(
      ApiConstants.myOrders,
      queryParameters: {
        if (status != null) 'status': status,
        'page': page,
        'limit': 20,
      },
      fromJson: (data) {
        if (data is List) {
          return data.map((e) => _parseOrder(e as Map<String, dynamic>)).toList();
        }
        final items = data['items'] as List? ?? [];
        return items.map((e) => _parseOrder(e as Map<String, dynamic>)).toList();
      },
    );
  }

  Future<ApiResponse<List<OrderEntity>>> getSellerOrders({String? status, int page = 1}) async {
    return _apiClient.get<List<OrderEntity>>(
      ApiConstants.sellerOrders,
      queryParameters: {
        if (status != null) 'status': status,
        'page': page,
        'limit': 20,
      },
      fromJson: (data) {
        if (data is List) {
          return data.map((e) => _parseOrder(e as Map<String, dynamic>)).toList();
        }
        final items = data['items'] as List? ?? [];
        return items.map((e) => _parseOrder(e as Map<String, dynamic>)).toList();
      },
    );
  }

  Future<ApiResponse<OrderEntity>> getOrderById(String id) async {
    return _apiClient.get<OrderEntity>(
      '${ApiConstants.orderDetail}$id',
      fromJson: (data) => _parseOrder(data as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<OrderEntity>> createOrder({required String listingId, String? notes}) async {
    return _apiClient.post<OrderEntity>(
      ApiConstants.createOrder,
      data: {'listingId': listingId, if (notes != null) 'notes': notes},
      fromJson: (data) => _parseOrder(data as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<void>> cancelOrder(String id) async {
    return _apiClient.patch<void>('${ApiConstants.cancelOrder}$id/cancel');
  }

  Future<ApiResponse<void>> confirmOrder(String id) async {
    return _apiClient.patch<void>('${ApiConstants.confirmOrder}$id/confirm');
  }

  Future<ApiResponse<void>> completeOrder(String id) async {
    return _apiClient.patch<void>('${ApiConstants.completeOrder}$id/complete');
  }

  OrderEntity _parseOrder(Map<String, dynamic> json) {
    final listing = json['listing'] as Map<String, dynamic>? ?? {};
    final images = listing['images'] as List? ?? [];
    return OrderEntity(
      id: json['id'] as String? ?? '',
      listingId: listing['id'] as String? ?? '',
      listingTitle: listing['title'] as String? ?? '',
      listingImage: images.isNotEmpty ? images[0].toString() : '',
      price: (json['totalAmount'] as num?)?.toInt() ?? (listing['price'] as num?)?.toInt() ?? 0,
      buyerId: (json['buyerId'] as Map<String, dynamic>?)?['id'] as String? ?? '',
      buyerName: (json['buyerId'] as Map<String, dynamic>?)?['name'] as String? ?? '',
      sellerId: (json['sellerId'] as Map<String, dynamic>?)?['id'] as String? ?? '',
      sellerName: (json['sellerId'] as Map<String, dynamic>?)?['name'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      completedAt: json['completedAt'] as String?,
    );
  }
}
