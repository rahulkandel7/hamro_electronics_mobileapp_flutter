import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_error.dart';
import 'package:hamro_electronics/core/api/dio_exception.dart';
import 'package:hamro_electronics/features/view_order/data/data_sources/order_view_data_source.dart';
import 'package:hamro_electronics/features/view_order/data/models/orderView.dart';

abstract class OrderViewRepository {
  Future<Either<ApiError, List<OrderView>>> getOrders();
}

final orderViewRepositoryProvider = Provider<OrderViewRepositoryImpl>((ref) {
  return OrderViewRepositoryImpl(ref.read(orderViewDataSourceProvider));
});

class OrderViewRepositoryImpl extends OrderViewRepository {
  final OrderViewDataSource _orderViewDataSource;

  OrderViewRepositoryImpl(this._orderViewDataSource);
  @override
  Future<Either<ApiError, List<OrderView>>> getOrders() async {
    try {
      final result = await _orderViewDataSource.getOrders();
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiError(message: e.message!));
    }
  }
}
