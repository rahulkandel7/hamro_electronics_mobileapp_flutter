import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:hamro_electronics/features/view_order/data/models/orderView.dart';

abstract class OrderViewDataSource {
  Future<List<OrderView>> getOrders();
}

final orderViewDataSourceProvider = Provider<OrderViewDataSourceImpl>((ref) {
  return OrderViewDataSourceImpl(ref.read(apiServiceProvider));
});

class OrderViewDataSourceImpl extends OrderViewDataSource {
  final ApiService _apiService;

  OrderViewDataSourceImpl(this._apiService);
  @override
  Future<List<OrderView>> getOrders() async {
    final result =
        await _apiService.getDataWithAuthorize(endpoint: 'user/order');

    final orders = result['data'] as List<dynamic>;
    List<OrderView> viewOrders = [];
    for (var order in orders) {
      final carts = order as List<dynamic>;
      for (var cart in carts) {
        viewOrders.add(OrderView(
          id: int.parse(cart['cart']['id'].toString()),
          productId: int.parse(cart['cart']['product_id']),
          productName: cart['cart']['productname'],
          productPhoto: cart['cart']['photopath'],
          color: cart['cart']['color'],
          quantity: int.parse(cart['cart']['quantity']),
          reason: cart['cart']['reason'] ?? '',
          size: cart['cart']['size'],
          status: cart['cart']['status'],
        ));
      }
    }
    return viewOrders;
  }
}
