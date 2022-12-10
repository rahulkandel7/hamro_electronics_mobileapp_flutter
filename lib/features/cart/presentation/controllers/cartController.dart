import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/cart/data/models/cart.dart';
import 'package:hamro_electronics/features/cart/data/repositories/cart_repository.dart';

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

  Future<bool> updateQuantity(int cartId, var pdata) async {
    final result = await _cartRepository.updateQuantity(cartId, pdata);
    return result.fold((l) => false, (r) => true);
  }

  Future<bool> deleteCart(int cartId) async {
    final result = await _cartRepository.removeFromCart(cartId);
    return result.fold((l) => false, (r) => true);
  }

  Future<bool> updateOrder(int cartId) async {
    var pdata = {'ordered': 1.toString()};
    final result = await _cartRepository.updateOrder(cartId, pdata);
    return result.fold((l) => false, (r) => true);
  }

  Future<bool> addToCart(var pdata) async {
    final result = await _cartRepository.addToCart(pdata);
    return result.fold((l) {
      state = AsyncError(l.message, StackTrace.fromString(l.toString()));
      return false;
    }, (r) => true);
  }
}

final cartControllerProvider =
    StateNotifierProvider<CartController, AsyncValue<List<Cart>>>((ref) {
  return CartController(ref.watch(cartRepositoryProvider));
});
