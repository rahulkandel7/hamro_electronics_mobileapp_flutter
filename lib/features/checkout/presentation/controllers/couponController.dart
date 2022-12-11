import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/checkout/data/models/coupon.dart';
import 'package:hamro_electronics/features/checkout/data/repositories/coupon_repository.dart';

class CouponController extends StateNotifier<AsyncValue<List<Coupon>>> {
  CouponController(this._couponRepository) : super(const AsyncLoading()) {
    fetchCoupon();
  }

  final CouponRepository _couponRepository;

  fetchCoupon() async {
    final result = await _couponRepository.getCoupon();
    result.fold(
      (error) {
        return state =
            AsyncError(error.message, StackTrace.fromString(error.toString()));
      },
      (success) => state = AsyncData(success),
    );
  }
}

final couponControllerProvider =
    StateNotifierProvider<CouponController, AsyncValue<List<Coupon>>>((ref) {
  return CouponController(ref.watch(couponRepositoryProvider));
});
