import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constants.dart';
import '../model/wishlist.dart';

class WishlistController extends StateNotifier<List<Wishlist>> {
  WishlistController(super.state);

  Future<List<Wishlist>> fetchWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.get(Uri.parse('${Constants.API}wishlist'), headers: {
      'Authorization': 'Bearer ${prefs.getString('token')}',
    });

    if (response.statusCode == 200) {
      final wishlists = jsonDecode(response.body)['data'] as List<dynamic>;

      state.clear();

      state = wishlists.map((wishlist) => Wishlist.fromMap(wishlist)).toList();
    }
    return state;
  }

  Future<http.Response> removeWishlist(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.delete(Uri.parse('${Constants.API}wishlist/$id'), headers: {
      'Authorization': 'Bearer ${prefs.getString('token')}',
    });

    return response;
  }

  Future<http.Response> addWishlist(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.post(Uri.parse('${Constants.API}wishlist'), body: {
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
