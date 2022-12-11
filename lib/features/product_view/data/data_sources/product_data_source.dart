import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:hamro_electronics/features/product_view/data/models/product.dart';

abstract class ProductDataSource {
  Future<List<Product>> getProducts();
}

final productDataSourceProvider = Provider<ProductDataSource>((ref) {
  return ProductDataSourceImpl(ref.read(apiServiceProvider));
});

class ProductDataSourceImpl extends ProductDataSource {
  final ApiService _apiService;
  ProductDataSourceImpl(this._apiService);
  @override
  Future<List<Product>> getProducts() async {
    final result = await _apiService.getData(endpoint: 'products');
    final products = result['data'] as List<dynamic>;

    return products.map((product) => Product.fromMap(product)).toList();
  }
}
