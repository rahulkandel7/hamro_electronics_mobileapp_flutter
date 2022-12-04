import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

import '../../../constants/constants.dart';
import '../model/subCategory.dart';

class SubCategoryController extends StateNotifier<List<SubCategory>> {
  SubCategoryController(super.createFn);

  Future<List<SubCategory>> fetchSubCategory() async {
    final response = await http.get(
      Uri.parse('${Constants.API}fetchSubCategory'),
    );

    if (response.statusCode == 200) {
      final subcategories = jsonDecode(response.body)['data'] as List<dynamic>;
      state.clear();
      state = subcategories
          .map((subCategory) => SubCategory.fromMap((subCategory)))
          .toList();
    }
    return state;
  }
}

var subCategoryProvider =
    StateNotifierProvider<SubCategoryController, List<SubCategory>>((ref) {
  return SubCategoryController([]);
});

var fetchSubCategory = FutureProvider((ref) {
  return ref.watch(subCategoryProvider.notifier).fetchSubCategory();
});
