import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_error.dart';
import 'package:hamro_electronics/core/api/dio_exception.dart';
import 'package:hamro_electronics/features/wihslist/data/data_sources/wishlist_data_source.dart';
import 'package:hamro_electronics/features/wihslist/data/models/wishlist.dart';

abstract class WishlistRepository {
  Future<Either<ApiError, List<Wishlist>>> getWishlist();
  Future<Either<ApiError, String>> addToWishlist(var pdata);
  Future<Either<ApiError, String>> removeFromWishlist(int id);
}

final wishlistRepositoryProvider = Provider<WishlistRepositoryImpl>((ref) {
  return WishlistRepositoryImpl(ref.read(wishlistDataSourceProvider));
});

class WishlistRepositoryImpl extends WishlistRepository {
  final WishlistDataSource _wishlistDataSource;

  WishlistRepositoryImpl(this._wishlistDataSource);
  @override
  Future<Either<ApiError, List<Wishlist>>> getWishlist() async {
    try {
      final result = await _wishlistDataSource.getWishlist();
      return Right(result);
    } on DioException catch (e) {
      return Left(
        ApiError(
          message: e.message!,
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, String>> addToWishlist(pdata) async {
    try {
      final result = await _wishlistDataSource.addToWishlist(pdata);
      return Right(result);
    } on DioException catch (e) {
      return Left(
        ApiError(
          message: e.message!,
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, String>> removeFromWishlist(id) async {
    try {
      final result = await _wishlistDataSource.removeFromWishlist(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(
        ApiError(
          message: e.message!,
        ),
      );
    }
  }
}
