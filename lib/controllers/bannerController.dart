import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/models/banner.dart';

class BannerController extends StateNotifier<List<Banner>> {
  BannerController(super.state);

  String url = 'https://api.hamroelectronics.com.np/api/v1/';

  Future<List<Banner>> fetchBanner() async {
    final response = await http.get(
      Uri.parse('${url}fetchbanner'),
    );

    final extractedData = json.decode(response.body);

    if (response.statusCode == 200) {
      final banners = extractedData['data'] as List<dynamic>;
      state.cast();
      for (var banner in banners) {
        state.add(
          Banner(
            id: banner['id'],
            photopath: banner['photopath'],
            priority: int.parse(
              banner['priority'],
            ),
          ),
        );
      }
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
