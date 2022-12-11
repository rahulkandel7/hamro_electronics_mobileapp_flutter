import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/brand.dart';
import '../../data/repositories/brand_repository.dart';

class BrandController extends StateNotifier<AsyncValue<List<Brand>>> {
  BrandController(this._brandRepository) : super(const AsyncLoading()) {
    fetchBrand();
  }
  final BrandRepository _brandRepository;

  fetchBrand() async {
    final result = await _brandRepository.getBrand();
    result.fold(
      (l) => state = AsyncError(
        l.message,
        StackTrace.fromString(
          l.message,
        ),
      ),
      (r) => state = AsyncData(r),
    );
  }

  Brand getBrand(int id) {
    return state.value!.firstWhere((element) => element.id == id);
  }
}

final brandControllerProvider =
    StateNotifierProvider<BrandController, AsyncValue<List<Brand>>>((ref) {
  return BrandController(ref.watch(brandRepositoryProvider));
});
