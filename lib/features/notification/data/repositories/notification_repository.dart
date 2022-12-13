import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_error.dart';
import 'package:hamro_electronics/core/api/dio_exception.dart';
import 'package:hamro_electronics/features/notification/data/data_sources/notification_data_source.dart';
import 'package:hamro_electronics/features/notification/data/models/notification.dart';

abstract class NotificationRepository {
  Future<Either<ApiError, List<Notification>>> getNotification();
}

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(ref.read(notificationDataSourceProvider));
});

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationDataSource _notificationDataSource;
  NotificationRepositoryImpl(this._notificationDataSource);
  @override
  Future<Either<ApiError, List<Notification>>> getNotification() async {
    try {
      final result = await _notificationDataSource.getNotification();
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiError(message: e.message!));
    }
  }
}
