import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:hamro_electronics/features/home/data/models/banner.dart';

abstract class BannerDataSource {
  Future<List<Banner>> getBanner();
}

final bannerDataSourceProvider = Provider<BannerDataSourceImpl>((ref) {
  return BannerDataSourceImpl(ref.read(apiServiceProvider));
});

class BannerDataSourceImpl extends BannerDataSource {
  final ApiService _apiService;

  BannerDataSourceImpl(this._apiService);
  @override
  Future<List<Banner>> getBanner() async {
    final result = await _apiService.getData(endpoint: 'fetchbanner');
    final banners = result['data'] as List<dynamic>;
    return banners.map((banner) => Banner.fromMap(banner)).toList();
  }
}
