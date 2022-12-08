import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/home/data/models/banner.dart';
import 'package:hamro_electronics/features/home/data/repositories/banner_repository.dart';

class BannerController extends StateNotifier<AsyncValue<List<Banner>>> {
  BannerController(this._bannerRepository) : super(const AsyncLoading()) {
    fetchBanner();
  }
  final BannerRepository _bannerRepository;

  fetchBanner() async {
    final result = await _bannerRepository.getBanner();
    result.fold(
        (l) => state = AsyncError(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncData(r));
  }
}

final bannerControllerProvider =
    StateNotifierProvider<BannerController, AsyncValue<List<Banner>>>((ref) {
  return BannerController(ref.read(bannerRepositoryProvider));
});
