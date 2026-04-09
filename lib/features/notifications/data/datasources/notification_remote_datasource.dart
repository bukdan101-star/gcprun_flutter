import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/constants/api_constants.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationRemoteDatasource {
  final ApiClient _apiClient;

  NotificationRemoteDatasource(this._apiClient);

  Future<ApiResponse<List<NotificationEntity>>> getNotifications({int page = 1, int limit = 20}) async {
    return _apiClient.get<List<NotificationEntity>>(
      ApiConstants.notifications,
      queryParameters: {'page': page, 'limit': limit},
      fromJson: (data) {
        if (data is List) {
          return data.map((e) => _parseNotification(e as Map<String, dynamic>)).toList();
        }
        final items = data['items'] as List? ?? [];
        return items.map((e) => _parseNotification(e as Map<String, dynamic>)).toList();
      },
    );
  }

  Future<ApiResponse<void>> markAsRead(String notificationId) async {
    return _apiClient.patch<void>(
      '${ApiConstants.markNotificationRead}$notificationId/read',
    );
  }

  Future<ApiResponse<void>> markAllAsRead() async {
    return _apiClient.patch<void>(ApiConstants.markAllNotificationsRead);
  }

  NotificationEntity _parseNotification(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      type: json['type'] as String? ?? 'info',
      isRead: json['isRead'] as bool? ?? false,
      data: json['data']?.toString(),
      createdAt: json['createdAt'] as String?,
    );
  }
}
