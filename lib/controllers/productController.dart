// import 'dart:convert';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hamro_electronics/models/product.dart';
// import 'package:http/http.dart' as http;

// class ProductController extends StateNotifier<List<Product>> {
//   ProductController(super.state);

//   String url = 'https://api.hamroelectronics.com.np/api/v1/';

//   Future<List<Product>> fetchProduct() async {
//     final response = await http.get(Uri.parse("${url}products"));

//     final extractedData = json.decode(response.body);

//     if (response.statusCode == 200) {
//       final products = extractedData['data'] as List<dynamic>;
//       state.clear();
//       for (var element in products) {
//         state.add(
//           Product(
//               brandId: int.parse(element['brand_id']),
//               categoryId: int.parse(element['category_id']),
//               color: element['color'],
//               deleted: int.parse(element['deleted']),
//               description: element['description'],
//               discountedprice:
//                   int.parse(element['discountedprice'] ?? 0.toString()),
//               flashsale: int.parse(element['flashsale']),
//               id: element['id'],
//               name: element['name'],
//               photopath1: element['photopath1'],
//               photopath2: element['photopath2'] ?? '',
//               photopath3: element['photopath3'] ?? '',
//               price: int.parse(element['price'] ?? ''),
//               size: element['size'],
//               sku: element['sku'],
//               status: int.parse(element['available']),
//               stock: int.parse(element['stock']),
//               subCategoryId:
//                   int.parse(element['sub_category_id'] ?? 0.toString()),
//               rating: double.tryParse(element['rating'].toString()),
//               ratingNumber: element['rating_number']),
//         );
//       }
//     }
//     return state;
//   }

//   Product findProduct(int id) {
//     return state.firstWhere((element) => element.id == id);
//   }

//   List<Product> findByCategory(int id) {
//     return state.where((element) => element.categoryId == id).toList();
//   }

//   List<Product> findBySubCategory(int id) {
//     return state.where((element) => element.subCategoryId == id).toList();
//   }

//   List<Product> searchProduct(String name) {
//     return state
//         .where(
//           (product) => product.name.toLowerCase().contains(
//                 name.toLowerCase(),
//               ),
//         )
//         .toList();
//   }
// }

// var productProvider =
//     StateNotifierProvider<ProductController, List<Product>>((ref) {
//   return ProductController([]);
// });

// var fetchProduct = FutureProvider<List<Product>>((ref) {
//   return ref.watch(productProvider.notifier).fetchProduct();
// });
