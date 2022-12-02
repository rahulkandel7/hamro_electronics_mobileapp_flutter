import 'dart:convert';

import 'package:hamro_electronics/src/constants/constants.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/coupon.dart';

class CouponController extends StateNotifier<List<Coupon>> {
  CouponController(super.state);

  Future<List<Coupon>> fetchCoupon() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      final response =
          await http.get(Uri.parse('${Constants.API}coupon'), headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
      });
      final extractedData = json.decode(response.body);

      if (response.statusCode == 200) {
        state.clear();
        final coupons = extractedData['data'];
        for (var coupon in coupons) {
          state.add(
            Coupon(
              id: coupon['id'],
              isAmoount: int.parse(coupon['isAmount']),
              isAvailable: int.parse(coupon['isAvailable']),
              isPercent: int.parse(coupon['isPercent']),
              maxDisAmount: int.parse(coupon['maxDisAmount']),
              minAmount: int.parse(coupon['minAmount']),
              name: coupon['name'],
              offerAmount: int.parse(coupon['offerAmount']),
              offerPercent: int.parse(coupon['offerPercent']),
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

var couponProvider =
    StateNotifierProvider<CouponController, List<Coupon>>((ref) {
  return CouponController([]);
});

var fetchCoupon = FutureProvider<List<Coupon>>((ref) {
  return ref.watch(couponProvider.notifier).fetchCoupon();
});
