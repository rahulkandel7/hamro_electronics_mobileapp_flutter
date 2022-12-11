import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_error.dart';
import 'package:hamro_electronics/core/api/dio_exception.dart';
import 'package:hamro_electronics/features/checkout/data/data_sources/coupon_data_source.dart';
import 'package:hamro_electronics/features/checkout/data/models/coupon.dart';

abstract class CouponRepository {
  Future<Either<ApiError, List<Coupon>>> getCoupon();
}

final couponRepositoryProvider = Provider<CouponRepositoryImpl>((ref) {
  return CouponRepositoryImpl(ref.read(couponDataSourceProvider));
});

class CouponRepositoryImpl extends CouponRepository {
  final CouponDataSource _couponDataSource;

  CouponRepositoryImpl(this._couponDataSource);
  @override
  Future<Either<ApiError, List<Coupon>>> getCoupon() async {
    try {
      final result = await _couponDataSource.getCoupon();
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiError(message: e.message!));
    }
  }
}
