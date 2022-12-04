import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constants.dart';
import '../model/cart.dart';

class CartController extends StateNotifier<List<Cart>> {
  CartController(super.state);

  Future<List<Cart>> fetchCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse('${Constants.API}cart'),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
      },
    );

    if (response.statusCode == 200) {
      final carts = json.decode(response.body)['data'] as List<dynamic>;

      state.clear();
      state = carts.map((cart) => Cart.fromMap(cart)).toList();
    }
    return state;
  }

  Future<dynamic> updateQuantity(int cartId, int quantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await http.post(Uri.parse('${Constants.API}update/$cartId'), headers: {
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
      Uri.parse('$Constants.API$cartId'),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
      },
    );

    return response;
  }

  updateOrder(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await http.post(Uri.parse('${Constants.API}update/ordered/$id'), body: {
      'ordered': 1.toString(),
    }, headers: {
      'Authorization': 'Bearer ${prefs.getString('token')}',
    });
  }

  Future<http.Response> addToCart(
      int productId, String color, String size, int price, int quantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse(Constants.API),
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
