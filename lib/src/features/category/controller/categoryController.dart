import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../models/category.dart';

class CategoryController extends StateNotifier<List<Category>> {
  CategoryController(super.createFn);

  Future<List<Category>> fetchCategory() async {
    final response = await http.get(Uri.parse('${Constants.API}fetchCategory'));

    final extractedData = json.decode(response.body);

    if (response.statusCode == 200) {
      final categories = extractedData['categories'] as List<dynamic>;
      state.clear();

      for (var element in categories) {
        state.add(
          Category(
            categoryName: element['category_name'],
            id: element['id'],
            photopath: element['photopath'],
            priority: int.parse(element['priority']),
          ),
        );
      }
    }

    return state;
  }

  Category findCategory(int id) {
    return state.firstWhere((element) => element.id == id);
  }
}

var categoryProvider =
    StateNotifierProvider<CategoryController, List<Category>>((ref) {
  return CategoryController([]);
});

var fetchCategory = FutureProvider<List<Category>>((ref) {
  return ref.watch(categoryProvider.notifier).fetchCategory();
});
