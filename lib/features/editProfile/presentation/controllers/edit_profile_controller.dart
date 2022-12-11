import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/editProfile/data/repositories/edit_profile_repository.dart';

class EditProfileController extends StateNotifier<AsyncValue> {
  EditProfileController(this._editProfileRepository)
      : super(const AsyncLoading());

  final EditProfileRepository _editProfileRepository;

  Future<List<String>> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    var pdata = {
      'current_password': currentPassword,
      'new_password': newPassword,
    };
    final result = await _editProfileRepository.changePassword(pdata);
    return result.fold((error) {
      List<String> msg = ['false', error.message];
      return msg;
    }, (success) {
      List<String> msg = ['true', success];
      return msg;
    });
  }

  Future<List<String>> changeUserInfo(
    String name,
    String phone,
    String address,
    String photopath,
  ) async {
    var pdata = {
      'name': name,
      'address': address,
      'phone_number': phone,
    };
    final result = await _editProfileRepository.changeUserInfo(pdata);
    return result.fold((error) {
      List<String> msg = ['false', error.message];
      return msg;
    }, (success) {
      List<String> msg = ['true', success];
      return msg;
    });
  }
}

final editProfileControllerProvider =
    StateNotifierProvider<EditProfileController, AsyncValue>((ref) {
  return EditProfileController(ref.watch(editProfileRepositoryProvider));
});
