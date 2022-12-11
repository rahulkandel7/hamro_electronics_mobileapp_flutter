import 'package:hamro_electronics/core/api/api_service.dart';

abstract class EditProfileDataSource {
  Future<String> editUserInfo(var pdata);
  Future<String> editPassword();
}

class EditProfileDataSourceImpl extends EditProfileDataSource {
  final ApiService _apiService;

  EditProfileDataSourceImpl(this._apiService);
  @override
  Future<String> editPassword() {
    // TODO: implement editUserInfo
    throw UnimplementedError();
  }

  @override
  Future<String> editUserInfo(var pdata) async {
    final result = await _apiService.postDataWithAuthorize(
        endpoint: 'user/update', pdata: pdata);
    return result['message'];
  }
}
