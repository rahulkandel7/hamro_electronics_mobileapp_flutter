import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/src/features/cart/model/cart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends StateNotifier<List<Cart>> {
  CartController(super.state);

  String url = 'https://api.hamroelectronics.com.np/api/v1/cart';

  Future<List<Cart>> fetchCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
      },
    );

    final extractedData = json.decode(response.body);

    if (response.statusCode == 200) {
      final carts = extractedData['data'] as List<dynamic>;
      state.clear();
      for (var cart in carts) {
        state.add(
          Cart(
            id: cart['id'],
            productId: int.parse(cart['product_id']),
            userId: int.parse(cart['user_id']),
            quantity: int.parse(cart['quantity']),
            color: cart['color'],
            size: cart['size'],
            status: cart['status'],
            ordered: int.parse(cart['ordered']),
            price: int.parse(cart['price']),
          ),
        );
      }
    }
    return state;
  }

  Future<dynamic> updateQuantity(int cartId, int quantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await http.post(Uri.parse('$url/update/$cartId'), headers: {
      'Authorization': 'Bearer ${prefs.getString('token')}',
    }, body: {
      'quantity': quantity.toString(),
    });

    final extractedData = json.decode(response.body);

    return extractedData;
  }

  Future<http.Response> deleteCart(int cartId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.delete(
      Uri.parse('$url/$cartId'),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
      },
    );

    return response;
  }

  updateOrder(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.post(Uri.parse('$url/update/ordered/$id'), body: {
      'ordered': 1.toString(),
    }, headers: {
      'Authorization': 'Bearer ${prefs.getString('token')}',
    });
  }

  Future<http.Response> addToCart(
      int productId, String color, String size, int price, int quantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse(url),
      body: {
        'product_id': productId.toString(),
        'color': color,
        'size': size,
        'price': price.toString(),
        'quantity': quantity.toString(),
        'ordered': '0',
      },
      headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
      },
    );

    return response;
  }
}

var cartProvider = StateNotifierProvider<CartController, List<Cart>>((ref) {
  return CartController([]);
});

var fetchCart = FutureProvider.autoDispose<List<Cart>>((ref) {
  return ref.watch(cartProvider.notifier).fetchCart();
});
