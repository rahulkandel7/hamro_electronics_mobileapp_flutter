import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/api_constants.dart';
import 'dio_exception.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

class ApiService {
  getData({required String endpoint}) async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.url,
        headers: {
          "accept": "application/json",
        },
      ),
    );
    try {
      final result = await dio.get(endpoint);
      return result.data;
    } on DioError catch (e) {
      throw DioException.fromDioError(e);
    }
  }

  getDataWithAuthorize({required String endpoint}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Dio dio = Dio(
      BaseOptions(baseUrl: ApiConstants.url, headers: {
        "accept": "application/json",
        'Authorization': 'Bearer ${prefs.getString('token')}',
      }),
    );
    try {
      final result = await dio.get(endpoint);
      return result.data;
    } on DioError catch (e) {
      throw DioException.fromDioError(e);
    }
  }

  postData({required String endpoint, var pdata}) async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.url,
        headers: {
          "accept": "application/json",
        },
      ),
    );
    try {
      final result = await dio.post(endpoint, data: pdata);
      return result.data;
    } on DioError catch (e) {
      throw DioException.fromDioError(e);
    }
  }

  postDataWithAuthorize({required String endpoint, var pdata}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.url,
        headers: {
          "accept": "application/json",
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      ),
    );
    try {
      final result = await dio.post(endpoint, data: pdata);
      return result.data;
    } on DioError catch (e) {
      throw DioException.fromDioError(e);
    }
  }

  deleteWithAuthorize({required String endpoint}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.url,
        headers: {
          "accept": "application/json",
          "authorization": 'Bearer ${prefs.getString('token')}',
        },
      ),
    );
    try {
      final result = await dio.delete(endpoint);
      return result.data;
    } on DioError catch (e) {
      throw DioException.fromDioError(e);
    }
  }
}
