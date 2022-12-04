import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../model/banner.dart';

class BannerController extends StateNotifier<List<Banner>> {
  BannerController(super.state);

  Future<List<Banner>> fetchBanner() async {
    final response = await http.get(
      Uri.parse('${Constants.API}fetchbanner'),
    );

    if (response.statusCode == 200) {
      final banners = jsonDecode(response.body)['data'] as List<dynamic>;
      state.clear();
      state = banners.map((banner) => Banner.fromMap(banner)).toList();
    }

    return state;
  }
}

var bannerProvider =
    StateNotifierProvider<BannerController, List<Banner>>((ref) {
  return BannerController([]);
});

var fetchBanner = FutureProvider<List<Banner>>((ref) {
  return ref.watch(bannerProvider.notifier).fetchBanner();
});
