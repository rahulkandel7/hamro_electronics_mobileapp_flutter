import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constants.dart';
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

      if (response.statusCode == 200) {
        final coupons = jsonDecode(response.body)['data'] as List<dynamic>;
        state.clear();
        state = coupons.map((coupon) => Coupon.fromMap(coupon)).toList();
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
