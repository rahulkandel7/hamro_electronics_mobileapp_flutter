import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/product_view/data/models/product.dart';
import 'package:hamro_electronics/features/product_view/data/repositories/product_repository.dart';

class ProductController extends StateNotifier<AsyncValue<List<Product>>> {
  ProductController(this._productRepository) : super(const AsyncLoading()) {
    fetchProduct();
  }

  final ProductRepository _productRepository;

  fetchProduct() async {
    final result = await _productRepository.getProducts();
    result.fold(
        (error) => state =
            AsyncError(error.message, StackTrace.fromString(error.toString())),
        (success) => state = AsyncData(success));
  }

  Product findProduct(int id) {
    return state.value!.firstWhere((element) => element.id == id);
  }

  List<Product> findByCategory(int id) {
    return state.value!.where((element) => element.categoryId == id).toList();
  }

  List<Product> findBySubCategory(int id) {
    return state.value!
        .where((element) => element.subCategoryId == id)
        .toList();
  }

  List<Product> searchProduct(String name) {
    return state.value!
        .where(
          (product) => product.name.toLowerCase().contains(
                name.toLowerCase(),
              ),
        )
        .toList();
  }
}

final productControllerProvider =
    StateNotifierProvider<ProductController, AsyncValue<List<Product>>>((ref) {
  return ProductController(ref.watch(productRepositoryProvider));
});
