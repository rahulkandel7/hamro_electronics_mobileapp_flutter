import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_error.dart';
import 'package:hamro_electronics/features/cart/data/data_sources/cart_data_sources.dart';

import '../models/cart.dart';

abstract class CartRepository {
  Future<Either<ApiError, List<Cart>>> fetchCart();
  Future<Either<ApiError, void>> addToCart(var pdata);
  Future<Either<ApiError, void>> removeFromCart(int cartId);
  Future<Either<ApiError, void>> updateQuantity(int cartId, var pdata);
  Future<Either<ApiError, void>> updateOrder(int cartId, var pdata);
}

final cartRepositoryProvider = Provider<CartRepositoryImpl>((ref) {
  return CartRepositoryImpl(ref.read(cartDataSourceProvider));
});

class CartRepositoryImpl extends CartRepository {
  final CartDataSource _cartDataSource;
  CartRepositoryImpl(this._cartDataSource);

  @override
  Future<Either<ApiError, void>> addToCart(pdata) async {
    try {
      final result = await _cartDataSource.addToCart(pdata);
      return Right(result);
    } on DioError catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiError, List<Cart>>> fetchCart() async {
    try {
      final result = await _cartDataSource.fetchCart();
      return Right(result);
    } on DioError catch (e) {
      return Left(ApiError(message: e.message));
    }
  }

  @override
  Future<Either<ApiError, void>> removeFromCart(int cartId) async {
    try {
      final result = await _cartDataSource.removeFromCart(cartId);
      return Right(result);
    } on DioError catch (e) {
      return Left(
        ApiError(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, void>> updateOrder(int cartId, pdata) async {
    try {
      final result = await _cartDataSource.updateOrder(cartId, pdata);
      return Right(result);
    } on DioError catch (e) {
      return Left(
        ApiError(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, void>> updateQuantity(int cartId, pdata) async {
    try {
      final result = await _cartDataSource.updateQuantity(cartId, pdata);
      return Right(result);
    } on DioError catch (e) {
      return Left(
        ApiError(
          message: e.message,
        ),
      );
    }
  }
}
