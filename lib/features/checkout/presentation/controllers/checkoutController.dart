import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/checkout/data/repositories/checkout_repository.dart';

class CheckoutController extends StateNotifier<AsyncValue> {
  CheckoutController(this._checkoutRepository) : super(const AsyncLoading());

  final CheckoutRepository _checkoutRepository;

  Future<List<String>> checkout(var pdata) async {
    final result = await _checkoutRepository.checkout(pdata);
    return result.fold((error) {
      List<String> msg = ['false', error.message];
      return msg;
    }, (success) {
      List<String> msg = ['true', success];
      return msg;
    });
  }
}

final checkoutControllerProvider =
    StateNotifierProvider<CheckoutController, AsyncValue>((ref) {
  return CheckoutController(ref.watch(checkoutRepositoryProvider));
});
