import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:hamro_electronics/features/checkout/data/models/shipping.dart';

abstract class ShippingDataSource {
  Future<List<Shipping>> getShipping();
}

final shippingDataSourceProvider = Provider<ShippingDataSource>((ref) {
  return ShippingDataSourceImpl(ref.read(apiServiceProvider));
});

class ShippingDataSourceImpl extends ShippingDataSource {
  final ApiService _apiService;

  ShippingDataSourceImpl(this._apiService);
  @override
  Future<List<Shipping>> getShipping() async {
    final result = await _apiService.getDataWithAuthorize(endpoint: 'shipping');
    final shippings = result['data'] as List<dynamic>;

    return shippings.map((shipping) => Shipping.fromMap(shipping)).toList();
  }
}
