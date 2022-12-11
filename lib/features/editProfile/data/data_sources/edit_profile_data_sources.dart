import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class EditProfileDataSource {
  Future<String> changeUserInfo(var pdata);
  Future<String> changePassword(var pdata);
}

final editProfileDataSourceProvider = Provider<EditProfileDataSource>((ref) {
  return EditProfileDataSourceImpl(ref.read(apiServiceProvider));
});

class EditProfileDataSourceImpl extends EditProfileDataSource {
  final ApiService _apiService;

  EditProfileDataSourceImpl(this._apiService);
  @override
  Future<String> changePassword(var pdata) async {
    final result = await _apiService.postDataWithAuthorize(
        endpoint: 'user/changepass', pdata: pdata);
    return result['message'];
  }

  @override
  Future<String> changeUserInfo(var pdata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await _apiService.postDataWithAuthorize(
        endpoint: 'user/update', pdata: pdata);

    prefs.remove('user');

    prefs.setString('user', jsonEncode(result['data']));
    return result['message'];
  }
}
