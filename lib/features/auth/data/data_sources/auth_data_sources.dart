import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthDataSources {
  Future<void> login(var pdata);
  Future<void> logout();
  Future<void> register(var pdata);
}

final authDataSourceProvider = Provider<AuthDataSources>((ref) {
  return AuthDataSourcesImpl(ref.read(apiServiceProvider));
});

class AuthDataSourcesImpl extends AuthDataSources {
  final ApiService _apiService;

  AuthDataSourcesImpl(this._apiService);
  @override
  Future<void> login(var pdata) async {
    final result = await _apiService.postData(endpoint: 'login', pdata: pdata);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', result['token']);
    prefs.setString('user', json.encode(result['user']));
    return result;
  }

  @override
  Future<void> logout() async {
    final result = await _apiService.postDataWithAuthorize(endpoint: 'logout');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('user');
    return result;
  }

  @override
  Future<void> register(pdata) async {
    final result =
        await _apiService.postData(endpoint: 'register', pdata: pdata);
    print(result);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', result['token']);
    prefs.setString('user', json.encode(result['user']));
    return result;
  }
}
