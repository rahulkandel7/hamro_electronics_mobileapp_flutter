import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/edit_profile_repository.dart';

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

  Future<List<String>> changeUserInfo({
    required String name,
    required String phone,
    required String address,
    required File photopath,
    required String email,
  }) async {
    FormData formData;
    if (photopath.path.isEmpty) {
      formData = FormData.fromMap({
        'name': name,
        'address': address,
        'email': email,
        'phone_number': phone,
      });
    } else {
      formData = FormData.fromMap({
        'name': name,
        'address': address,
        'email': email,
        'phone_number': phone,
        'profile_photo': await MultipartFile.fromFile(photopath.path)
      });
    }

    final result = await _editProfileRepository.changeUserInfo(formData);
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
