import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/checkout/data/models/shipping.dart';
import 'package:hamro_electronics/features/checkout/data/repositories/shiiping_repository.dart';

class ShippingController extends StateNotifier<AsyncValue<List<Shipping>>> {
  ShippingController(this._shippingRepository) : super(const AsyncLoading()) {
    fetchShipping();
  }

  final ShippingRepository _shippingRepository;

  fetchShipping() async {
    final result = await _shippingRepository.getShipping();
    result.fold(
        (error) => state =
            AsyncError(error.message, StackTrace.fromString(error.toString())),
        (success) => state = AsyncData(success));
  }
}

final shippingControllerProvider =
    StateNotifierProvider<ShippingController, AsyncValue<List<Shipping>>>(
        (ref) {
  return ShippingController(ref.watch(shippingRepositoryProvider));
});
