import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:hamro_electronics/models/subCategory.dart';

class SubCategoryController extends StateNotifier<List<SubCategory>> {
  SubCategoryController(super.createFn);

  String url = "https://api.hamroelectronics.com.np/api/v1/";

  Future<List<SubCategory>> fetchSubCategory() async {
    final response = await http.get(
      Uri.parse('${url}fetchSubCategory'),
    );

    final extractedData = json.decode(response.body);
    if (response.statusCode == 200) {
      final subcategories = extractedData['data'] as List<dynamic>;
      state.clear();

      for (var subCategory in subcategories) {
        state.add(
          SubCategory(
            categoryId: int.parse(subCategory['category_id']),
            id: subCategory['id'],
            priority: int.parse(subCategory['priority']),
            subCategoryName: subCategory['subcategory_name'],
          ),
        );
      }
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
