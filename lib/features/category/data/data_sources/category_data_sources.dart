import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:hamro_electronics/features/category/data/models/Category.dart';

abstract class CategoryDataSource {
  Future<List<Category>> getCategory();
}

final categoryDataSourceProvider = Provider<CategoryDataSourceImpl>((ref) {
  return CategoryDataSourceImpl(ref.read(apiServiceProvider));
});

class CategoryDataSourceImpl extends CategoryDataSource {
  final ApiService _apiService;

  CategoryDataSourceImpl(this._apiService);
  @override
  Future<List<Category>> getCategory() async {
    final result = await _apiService.getData(endpoint: 'fetchCategory');
    final categories = result['categories'] as List<dynamic>;

    return categories.map((e) => Category.fromMap(e)).toList();
  }
}
