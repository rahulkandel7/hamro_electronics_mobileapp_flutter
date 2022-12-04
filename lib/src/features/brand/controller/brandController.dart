import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../constants/constants.dart';
import '../model/brand.dart';

class BrandController extends StateNotifier<List<Brand>> {
  BrandController(super.state);

  Future<List<Brand>> fetchBrand() async {
    final response = await http.get(Uri.parse('${Constants.API}fetchBrand'));

    if (response.statusCode == 200) {
      final brands = jsonDecode(response.body)['data'] as List<dynamic>;

      state.clear();
      state = brands.map((brand) => Brand.fromMap(brand)).toList();
    }

    return state;
  }

  Brand getBrand(int id) {
    return state.firstWhere((element) => element.id == id);
  }
}

var brandProvider = StateNotifierProvider<BrandController, List<Brand>>((ref) {
  return BrandController([]);
});

var fetchBrand = FutureProvider<List<Brand>>((ref) {
  return ref.watch(brandProvider.notifier).fetchBrand();
});
