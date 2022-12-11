import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_error.dart';
import 'package:hamro_electronics/core/api/dio_exception.dart';
import 'package:hamro_electronics/features/checkout/data/data_sources/checkout_data_source.dart';

abstract class CheckoutRepository {
  Future<Either<ApiError, String>> checkout(var pdata);
}

final checkoutRepositoryProvider = Provider<CheckoutRepository>((ref) {
  return CheckoutRepositoryImpl(ref.read(checkoutDataSourceProvider));
});

class CheckoutRepositoryImpl extends CheckoutRepository {
  final CheckoutDataSource _checkoutDataSource;
  CheckoutRepositoryImpl(this._checkoutDataSource);

  @override
  Future<Either<ApiError, String>> checkout(var pdata) async {
    try {
      final result = await _checkoutDataSource.checkout(pdata);
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiError(message: e.message!));
    }
  }
}
