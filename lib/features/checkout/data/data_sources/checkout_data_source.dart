import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';

abstract class CheckoutDataSource {
  Future<String> checkout(var pdata);
}

final checkoutDataSourceProvider = Provider<CheckoutDataSourceImpl>((ref) {
  return CheckoutDataSourceImpl(ref.read(apiServiceProvider));
});

class CheckoutDataSourceImpl extends CheckoutDataSource {
  final ApiService _apiService;

  CheckoutDataSourceImpl(this._apiService);
  @override
  Future<String> checkout(var pdata) async {
    final result = await _apiService.postDataWithAuthorize(
        endpoint: 'order/store', pdata: pdata);
    return result['message'];
  }
}
