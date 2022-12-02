import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:hamro_electronics/src/features/view_order/model/status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusController extends StateNotifier<List<Status>> {
  StatusController(super.state);

  String url = 'https://api.hamroelectronics.com.np/api/v1/user/order';

  Future<List<Status>> fetchOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
      },
    );

    print(response.body);
    final extractedData = json.decode(response.body);

    if (response.statusCode == 200) {
      final orders = extractedData['data'] as List<dynamic>;
      state.clear();

      for (var order in orders) {
        final carts = order as List<dynamic>;
        for (var cart in carts) {
          state.add(
            Status(
              id: int.parse(cart['cart']['id'].toString()),
              productId: int.parse(cart['cart']['product_id']),
              productName: cart['cart']['productname'],
              productPhoto: cart['cart']['photopath'],
              color: cart['cart']['color'],
              quantity: int.parse(cart['cart']['quantity']),
              reason: cart['cart']['reason'] ?? '',
              size: cart['cart']['size'],
              status: cart['cart']['status'],
            ),
          );
        }
      }
    }

    return state;
  }
}

var statusProvider =
    StateNotifierProvider.autoDispose<StatusController, List<Status>>((ref) {
  return StatusController([]);
});

var fetchStatus = FutureProvider.autoDispose<List<Status>>((ref) {
  return ref.watch(statusProvider.notifier).fetchOrders();
});
