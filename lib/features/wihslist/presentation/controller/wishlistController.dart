import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/wihslist/data/model/wishlist.dart';
import 'package:hamro_electronics/features/wihslist/data/repository/wishlist_repository.dart';

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

  addToWishlist(int id) async {
    var data = {'product_id': id};
    final result = await _wishlistRepository.addToWishlist(data);
    result.fold(
      (error) => state =
          AsyncError(error.message, StackTrace.fromString(error.message)),
      (sucess) => null,
    );
  }

  removeFromWishlist(int id) async {
    final result = await _wishlistRepository.removeFromWishlist(id);
    result.fold(
        (error) => state =
            AsyncError(error.message, StackTrace.fromString(error.message)),
        (sucess) => state);
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
