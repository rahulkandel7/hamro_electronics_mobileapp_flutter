import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:hamro_electronics/features/checkout/data/models/coupon.dart';

abstract class CouponDataSource {
  Future<List<Coupon>> getCoupon();
}

final couponDataSourceProvider = Provider<CouponDataSourceImpl>((ref) {
  return CouponDataSourceImpl(ref.read(apiServiceProvider));
});

class CouponDataSourceImpl extends CouponDataSource {
  final ApiService _apiService;
  CouponDataSourceImpl(this._apiService);
  @override
  Future<List<Coupon>> getCoupon() async {
    final result = await _apiService.getDataWithAuthorize(endpoint: 'coupon');
    final coupons = result['data'] as List<dynamic>;
    return coupons.map((coupon) => Coupon.fromMap(coupon)).toList();
  }
}
