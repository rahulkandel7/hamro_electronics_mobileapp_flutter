import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/cart.dart';
import '../../data/repositories/cart_repository.dart';

class CartController extends StateNotifier<AsyncValue<List<Cart>>> {
  CartController(this._cartRepository) : super(const AsyncLoading()) {
    fetchCart();
  }

  final CartRepository _cartRepository;

  fetchCart() async {
    final result = await _cartRepository.fetchCart();
    result.fold(
      (l) => state = AsyncError(l.message, StackTrace.fromString(l.message)),
      (r) => state = AsyncData(r),
    );
  }

  Future<List<String>> updateQuantity(int cartId, int quantity) async {
    var pdata = {'quantity': quantity};
    final result = await _cartRepository.updateQuantity(cartId, pdata);

    return result.fold((error) {
      List<String> msg = ['false', error.message];
      return msg;
    }, (success) {
      fetchCart();
      List<String> msg = ['true', success];
      return msg;
    });
  }

  Future<List<String>> deleteCart(int cartId) async {
    final result = await _cartRepository.removeFromCart(cartId);
    return result.fold((error) {
      List<String> msg = ['false', error.message];
      return msg;
    }, (success) {
      List<String> msg = ['true', success];
      fetchCart();
      return msg;
    });
  }

  Future<bool> updateOrder(int cartId) async {
    var pdata = {'ordered': 1.toString()};
    final result = await _cartRepository.updateOrder(cartId, pdata);
    return result.fold((l) => false, (r) {
      fetchCart();
      return true;
    });
  }

  Future<List<String>> addToCart(var pdata) async {
    final result = await _cartRepository.addToCart(pdata);
    return result.fold((error) {
      final errors = error.message.split(',');
      List<String> msg = ['false'];

      for (var element in errors) {
        msg.add(
          element
              .replaceAll('{', '')
              .replaceAll('}', '')
              .replaceAll('[', '')
              .replaceAll(']', ''),
        );
      }

      return msg;
    }, (success) {
      List<String> msg = ['true', success];
      fetchCart();
      return msg;
    });
  }
}

final cartControllerProvider =
    StateNotifierProvider<CartController, AsyncValue<List<Cart>>>((ref) {
  return CartController(ref.watch(cartRepositoryProvider));
});
