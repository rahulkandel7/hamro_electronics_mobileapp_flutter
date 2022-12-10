import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:hamro_electronics/features/cart/data/models/cart.dart';

abstract class CartDataSource {
  Future<List<Cart>> fetchCart();
  Future<void> addToCart(var pdata);
  Future<void> removeFromCart(int cartId);
  Future<void> updateQuantity(int cartId, var pdata);
  Future<void> updateOrder(int cartId, var pdata);
}

final cartDataSourceProvider = Provider<CartDataSourceImpl>((ref) {
  return CartDataSourceImpl(ref.read(apiServiceProvider));
});

class CartDataSourceImpl extends CartDataSource {
  final ApiService _apiService;
  CartDataSourceImpl(this._apiService);
  @override
  Future<void> addToCart(pdata) async {
    final result =
        await _apiService.postDataWithAuthorize(endpoint: 'cart', pdata: pdata);
    return result;
  }

  @override
  Future<List<Cart>> fetchCart() async {
    final result = await _apiService.getDataWithAuthorize(endpoint: 'cart');
    final carts = result['data'] as List<dynamic>;
    return carts.map((cart) => Cart.fromMap(cart)).toList();
  }

  @override
  Future<void> removeFromCart(int cartId) async {
    final result =
        await _apiService.deleteWithAuthorize(endpoint: 'cart/$cartId');
    return result;
  }

  @override
  Future<void> updateOrder(int cartId, pdata) async {
    final result = await _apiService.postDataWithAuthorize(
        endpoint: 'cart/update/ordered/$cartId', pdata: pdata);
    return result;
  }

  @override
  Future<void> updateQuantity(int cartId, pdata) async {
    final result = await _apiService.postDataWithAuthorize(
        endpoint: 'cart/update/ordered/$cartId', pdata: pdata);
    return result;
  }
}
