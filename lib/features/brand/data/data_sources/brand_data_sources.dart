import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:hamro_electronics/features/brand/data/models/brand.dart';

abstract class BrandDataSource {
  Future<List<Brand>> getBrand();
}

final brandDataSourceProvider = Provider<BrandDataSourceImpl>((ref) {
  return BrandDataSourceImpl(ref.read(apiServiceProvider));
});

class BrandDataSourceImpl extends BrandDataSource {
  final ApiService _apiService;

  BrandDataSourceImpl(this._apiService);
  @override
  Future<List<Brand>> getBrand() async {
    final result = await _apiService.getData(endpoint: 'fetchBrand');
    final brands = result['data'] as List<dynamic>;
    return brands.map((brand) => Brand.fromMap(brand)).toList();
  }
}
