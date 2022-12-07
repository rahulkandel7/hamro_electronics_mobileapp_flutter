import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/category/data/models/Category.dart';
import 'package:hamro_electronics/features/category/data/repositories/category_repositories.dart';

class CategoryController extends StateNotifier<AsyncValue<List<Category>>> {
  CategoryController(this._categoryRepository) : super(const AsyncLoading()) {
    fetchCategory();
  }

  final CategoryRepository _categoryRepository;
  fetchCategory() async {
    final result = await _categoryRepository.getCategory();
    result.fold(
      (l) => state = AsyncError(
        l.toString(),
        StackTrace.fromString(
          l.message,
        ),
      ),
      (r) {
        log(r.toString());
        return state = AsyncData(r);
      },
    );
  }

  Category findCategory(int id) {
    return state.value!.firstWhere((category) => category.id == id);
  }
}

final categoryControllerProvider =
    StateNotifierProvider<CategoryController, AsyncValue<List<Category>>>(
        (ref) {
  return CategoryController(ref.read(categoryRepoProvider));
});
