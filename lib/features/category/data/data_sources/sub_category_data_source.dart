import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:hamro_electronics/features/category/data/models/subCategory.dart';

abstract class SubCategoryDataSource {
  Future<List<SubCategory>> getSubCategory();
}

final subCategoryDataSourceProvider =
    Provider<SubCategoryDataSourceImpl>((ref) {
  return SubCategoryDataSourceImpl(ref.read(apiServiceProvider));
});

class SubCategoryDataSourceImpl extends SubCategoryDataSource {
  final ApiService _apiService;
  SubCategoryDataSourceImpl(this._apiService);
  @override
  Future<List<SubCategory>> getSubCategory() async {
    final result = await _apiService.getData(endpoint: 'fetchSubCategory');
    final subCategories = result['data'] as List<dynamic>;
    return subCategories
        .map((subCategory) => SubCategory.fromMap(subCategory))
        .toList();
  }
}
