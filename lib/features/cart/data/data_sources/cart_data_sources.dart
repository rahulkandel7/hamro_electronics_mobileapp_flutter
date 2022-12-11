import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:hamro_electronics/features/cart/data/models/cart.dart';

abstract class CartDataSource {
  Future<List<Cart>> fetchCart();
  Future<String> addToCart(var pdata);
  Future<String> removeFromCart(int cartId);
  Future<String> updateQuantity(int cartId, var pdata);
  Future<void> updateOrder(int cartId, var pdata);
}

final cartDataSourceProvider = Provider<CartDataSourceImpl>((ref) {
  return CartDataSourceImpl(ref.read(apiServiceProvider));
});

class CartDataSourceImpl extends CartDataSource {
  final ApiService _apiService;
  CartDataSourceImpl(this._apiService);
  @override
  Future<String> addToCart(pdata) async {
    final result =
        await _apiService.postDataWithAuthorize(endpoint: 'cart', pdata: pdata);
    return result['message'];
  }

  @override
  Future<List<Cart>> fetchCart() async {
    final result = await _apiService.getDataWithAuthorize(endpoint: 'cart');
    final carts = result['data'] as List<dynamic>;
    return carts.map((cart) => Cart.fromMap(cart)).toList();
  }

  @override
  Future<String> removeFromCart(int cartId) async {
    final result =
        await _apiService.deleteWithAuthorize(endpoint: 'cart/$cartId');
    return result['message'];
  }

  @override
  Future<void> updateOrder(int cartId, pdata) async {
    final result = await _apiService.postDataWithAuthorize(
        endpoint: 'cart/update/ordered/$cartId', pdata: pdata);
    return result;
  }

  @override
  Future<String> updateQuantity(int cartId, pdata) async {
    final result = await _apiService.postDataWithAuthorize(
        endpoint: 'cart/update/$cartId', pdata: pdata);
    return result['message'];
  }
}
