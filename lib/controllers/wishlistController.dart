import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/models/wishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistController extends StateNotifier<List<Wishlist>> {
  WishlistController(super.state);

  String url = "https://api.hamroelectronics.com.np/api/v1/";

  Future<List<Wishlist>> fetchWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('${url}wishlist'), headers: {
      'Authorization': 'Bearer ${prefs.getString('token')}',
    });
    final extractedData = json.decode(response.body);

    if (response.statusCode == 200) {
      final wishlists = extractedData['data'] as List<dynamic>;

      state.clear();

      for (var wishlist in wishlists) {
        state.add(
          Wishlist(
            id: wishlist['id'],
            productId: int.parse(wishlist['product_id']),
          ),
        );
      }
    }
    return state;
  }

  Future<http.Response> removeWishlist(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.delete(Uri.parse('${url}wishlist/$id'), headers: {
      'Authorization': 'Bearer ${prefs.getString('token')}',
    });

    return response;
  }

  Future<http.Response> addWishlist(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse('${url}wishlist'), body: {
      'product_id': id.toString(),
    }, headers: {
      'Authorization': 'Bearer ${prefs.getString('token')}',
    });

    return response;
  }

  bool isWishlist(int id) {
    List<Wishlist> w =
        state.where((element) => element.productId == id).toList();
    if (w.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}

var wishlistProvider =
    StateNotifierProvider.autoDispose<WishlistController, List<Wishlist>>(
        (ref) {
  return WishlistController([]);
});

var fetchWishlist = FutureProvider.autoDispose<List<Wishlist>>((ref) {
  return ref.watch(wishlistProvider.notifier).fetchWishlist();
});
