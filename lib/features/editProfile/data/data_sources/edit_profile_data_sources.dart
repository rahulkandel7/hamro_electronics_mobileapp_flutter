import 'package:hamro_electronics/core/api/api_service.dart';

abstract class EditProfileDataSource {
  Future<String> editUserInfo();
  Future<String> editPassword();
}

class EditProfileDataSourceImpl extends EditProfileDataSource {
  final ApiService _apiService;

  EditProfileDataSourceImpl(this._apiService);
  @override
  Future<String> editPassword() {
    // TODO: implement editPassword
    throw UnimplementedError();
  }

  @override
  Future<String> editUserInfo() {
    // TODO: implement editUserInfo
    throw UnimplementedError();
  }
}
