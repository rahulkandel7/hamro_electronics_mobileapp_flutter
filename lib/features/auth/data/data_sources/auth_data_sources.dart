import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthDataSources {
  Future<String> login(var pdata);
  Future<String> logout();
  Future<String> register(var pdata);
}

final authDataSourceProvider = Provider<AuthDataSources>((ref) {
  return AuthDataSourcesImpl(ref.read(apiServiceProvider));
});

class AuthDataSourcesImpl extends AuthDataSources {
  final ApiService _apiService;

  AuthDataSourcesImpl(this._apiService);
  @override
  Future<String> login(var pdata) async {
    final result = await _apiService.postData(endpoint: 'login', pdata: pdata);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', result['token']);
    prefs.setString('user', json.encode(result['user']));
    return result['message'];
  }

  @override
  Future<String> logout() async {
    final result = await _apiService.postDataWithAuthorize(endpoint: 'logout');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('user');
    return result['message'];
  }

  @override
  Future<String> register(pdata) async {
    final result =
        await _apiService.postData(endpoint: 'register', pdata: pdata);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', result['token']);
    prefs.setString('user', json.encode(result['user']));
    return result['message'];
  }
}
