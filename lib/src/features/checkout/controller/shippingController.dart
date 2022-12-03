import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constants.dart';
import '../model/shipping.dart';

class ShippingController extends StateNotifier<List<Shipping>> {
  ShippingController(super.state);

  Future<List<Shipping>> fetchShipping() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      final response = await http.get(
        Uri.parse('${Constants.API}shipping'),
        headers: {
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );

      final extractedData = json.decode(response.body);

      if (response.statusCode == 200) {
        state.clear();
        final shippings = extractedData['data'] as List<dynamic>;

        for (var shipping in shippings) {
          state.add(
            Shipping(
              id: shipping['id'],
              name: shipping['area_name'],
              price: int.parse(
                shipping['price'],
              ),
            ),
          );
        }
      }

      return state;
    } else {
      throw Exception('No Token Found');
    }
  }
}

var shippingProvider =
    StateNotifierProvider<ShippingController, List<Shipping>>((ref) {
  return ShippingController([]);
});

var fetchShipping = FutureProvider<List<Shipping>>((ref) {
  return ref.watch(shippingProvider.notifier).fetchShipping();
});
