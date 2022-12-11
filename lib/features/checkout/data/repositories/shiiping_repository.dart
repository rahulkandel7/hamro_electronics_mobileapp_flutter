import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_error.dart';
import 'package:hamro_electronics/core/api/dio_exception.dart';
import 'package:hamro_electronics/features/checkout/data/data_sources/shipping_data_source.dart';
import 'package:hamro_electronics/features/checkout/data/models/shipping.dart';

abstract class ShippingRepository {
  Future<Either<ApiError, List<Shipping>>> getShipping();
}

final shippingRepositoryProvider = Provider<ShippingRepository>((ref) {
  return ShippingRepositoryImpl(ref.read(shippingDataSourceProvider));
});

class ShippingRepositoryImpl extends ShippingRepository {
  final ShippingDataSource _shippingDataSource;

  ShippingRepositoryImpl(this._shippingDataSource);
  @override
  Future<Either<ApiError, List<Shipping>>> getShipping() async {
    try {
      final result = await _shippingDataSource.getShipping();
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiError(message: e.message!));
    }
  }
}
