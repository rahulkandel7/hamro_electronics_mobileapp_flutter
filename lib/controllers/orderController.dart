// import 'package:http/http.dart' as http;

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OrderController extends StateNotifier {
//   OrderController(super.state);

//   String url = 'https://api.hamroelectronics.com.np/api/v1/';

//   Future<http.Response> placeOrder(
//     List<String> cartId,
//     int shippingId,
//     int couponId,
//     int couponAmount,
//     int deliveryCharge,
//     String shippingAddress,
//     String phone,
//     String fullname,
//   ) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final response = await http.post(
//       Uri.parse(
//         '${url}order/store',
//       ),
//       body: {
//         'cart_id': cartId.toString().replaceAll('[', '').replaceAll(']', ''),
//         'shipping_id': shippingId.toString(),
//         'coupon_id': couponId.toString(),
//         'coupon_amount': couponAmount.toString(),
//         'delivery_charge': deliveryCharge.toString(),
//         'shipping_address': shippingAddress,
//         'phone': phone,
//         'fullname': fullname,
//       },
//       headers: {
//         'Authorization': 'Bearer ${prefs.getString('token')}',
//       },
//     );

//     return response;
//   }
// }

// var orderProvider = StateNotifierProvider((ref) {
//   return OrderController([]);
// });
