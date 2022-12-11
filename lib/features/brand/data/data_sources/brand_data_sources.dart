import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_service.dart';
import '../models/brand.dart';

abstract class BrandDataSource {
  Future<List<Brand>> getBrand();
}

final brandDataSourceProvider = Provider<BrandDataSource>((ref) {
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
