import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/notification/data/models/notification.dart';
import 'package:hamro_electronics/features/notification/data/repositories/notification_repository.dart';

class NotificationController
    extends StateNotifier<AsyncValue<List<Notification>>> {
  NotificationController(this._notificationRepository)
      : super(const AsyncLoading()) {
    fetchNotification();
  }
  final NotificationRepository _notificationRepository;
  fetchNotification() async {
    final result = await _notificationRepository.getNotification();
    result.fold(
        (error) => state =
            AsyncError(error.message, StackTrace.fromString(error.toString())),
        (success) => state = AsyncData(success));
  }
}

final notificationControllerProvider = StateNotifierProvider<
    NotificationController, AsyncValue<List<Notification>>>((ref) {
  return NotificationController(ref.watch(notificationRepositoryProvider));
});
