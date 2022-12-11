import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_error.dart';
import 'package:hamro_electronics/core/api/dio_exception.dart';
import 'package:hamro_electronics/features/product_view/data/data_sources/product_data_source.dart';
import 'package:hamro_electronics/features/product_view/data/models/product.dart';

abstract class ProductRepository {
  Future<Either<ApiError, List<Product>>> getProducts();
}

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(ref.read(productDataSourceProvider));
});

class ProductRepositoryImpl extends ProductRepository {
  final ProductDataSource _productDataSource;

  ProductRepositoryImpl(this._productDataSource);
  @override
  Future<Either<ApiError, List<Product>>> getProducts() async {
    try {
      final result = await _productDataSource.getProducts();
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiError(message: e.message!));
    }
  }
}
