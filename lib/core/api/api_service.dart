import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/constants/api_constants.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

class ApiService {
  getData({required String endpoint}) async {
    final Dio dio = Dio(
      BaseOptions(baseUrl: ApiConstants.url, headers: {
        "accept": "application/json",
      }),
    );
    try {
      final result = await dio.get(endpoint);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }
}
