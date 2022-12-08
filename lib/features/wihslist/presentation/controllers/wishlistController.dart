import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/wihslist/data/models/wishlist.dart';
import 'package:hamro_electronics/features/wihslist/data/repositories/wishlist_repository.dart';

class WishlistController extends StateNotifier<AsyncValue<List<Wishlist>>> {
  WishlistController(this._wishlistRepository) : super(const AsyncLoading()) {
    fetchWishlist();
  }

  final WishlistRepository _wishlistRepository;

  fetchWishlist() async {
    final result = await _wishlistRepository.getWishlist();
    result.fold(
      (l) => state = AsyncError(l.message, StackTrace.fromString(l.message)),
      (r) => state = AsyncData(r),
    );
  }

  Future<bool> addToWishlist(int id) async {
    var data = {'product_id': id};
    final result = await _wishlistRepository.addToWishlist(data);
    return result.fold(
      (error) => false,
      (sucess) => true,
    );
  }

  Future<bool> removeFromWishlist(int id) async {
    final result = await _wishlistRepository.removeFromWishlist(id);
    return result.fold((error) => false, (sucess) => true);
  }

  bool isWishlist(int id) {
    List<Wishlist> w =
        state.value!.where((element) => element.productId == id).toList();
    if (w.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}

final wishlistControllerProvider =
    StateNotifierProvider<WishlistController, AsyncValue<List<Wishlist>>>(
        (ref) {
  return WishlistController(ref.read(wishlistRepositoryProvider));
});
