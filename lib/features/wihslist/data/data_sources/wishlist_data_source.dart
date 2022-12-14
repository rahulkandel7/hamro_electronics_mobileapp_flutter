import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:hamro_electronics/features/wihslist/data/models/wishlist.dart';

abstract class WishlistDataSource {
  Future<List<Wishlist>> getWishlist();
  Future<String> addToWishlist(var pdata);
  Future<String> removeFromWishlist(int id);
}

final wishlistDataSourceProvider = Provider<WishlistDataSource>((ref) {
  return WishlistDataSourceImpl(ref.read(apiServiceProvider));
});

class WishlistDataSourceImpl extends WishlistDataSource {
  final ApiService _apiService;

  WishlistDataSourceImpl(this._apiService);
  @override
  Future<List<Wishlist>> getWishlist() async {
    final result = await _apiService.getDataWithAuthorize(endpoint: 'wishlist');
    final wishlists = result['data'] as List<dynamic>;
    return wishlists.map((wishlist) => Wishlist.fromMap(wishlist)).toList();
  }

  @override
  Future<String> addToWishlist(var pdata) async {
    final result = await _apiService.postDataWithAuthorize(
        endpoint: 'wishlist', pdata: pdata);

    return result['message'];
  }

  @override
  Future<String> removeFromWishlist(id) async {
    final result =
        await _apiService.deleteWithAuthorize(endpoint: 'wishlist/$id');
    return result['message'];
  }
}
