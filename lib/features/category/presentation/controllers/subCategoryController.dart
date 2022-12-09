import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/category/data/models/subCategory.dart';
import 'package:hamro_electronics/features/category/data/repositories/subCategory_repository.dart';

class SubCategoryController
    extends StateNotifier<AsyncValue<List<SubCategory>>> {
  SubCategoryController(this._subCategoryRepository)
      : super(const AsyncLoading()) {
    fetchSubCategory();
  }
  final SubCategoryRepository _subCategoryRepository;

  fetchSubCategory() async {
    final result = await _subCategoryRepository.getSubCategory();
    result.fold(
      (l) => state = AsyncError(l.message, StackTrace.fromString(l.toString())),
      (r) => state = AsyncData(r),
    );
  }
}

final subCategoryControllerProvider =
    StateNotifierProvider<SubCategoryController, AsyncValue<List<SubCategory>>>(
        (ref) {
  return SubCategoryController(ref.watch(subCategoryRepositoryProvider));
});
