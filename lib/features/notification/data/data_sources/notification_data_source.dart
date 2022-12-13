import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:hamro_electronics/features/notification/data/models/notification.dart';

abstract class NotificationDataSource {
  Future<List<Notification>> getNotification();
}

final notificationDataSourceProvider = Provider<NotificationDataSource>((ref) {
  return NotificationDataSourceImpl(ref.read(apiServiceProvider));
});

class NotificationDataSourceImpl extends NotificationDataSource {
  final ApiService _apiService;
  NotificationDataSourceImpl(this._apiService);
  @override
  Future<List<Notification>> getNotification() async {
    final result = await _apiService.getData(endpoint: 'notification');
    final notifications = result['data'] as List<dynamic>;

    return notifications
        .map((notification) => Notification.fromMap(notification))
        .toList();
  }
}
