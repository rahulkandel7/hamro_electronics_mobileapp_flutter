import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_error.dart';
import 'package:hamro_electronics/core/api/dio_exception.dart';
import 'package:hamro_electronics/features/editProfile/data/data_sources/edit_profile_data_sources.dart';

abstract class EditProfileRepository {
  Future<Either<ApiError, String>> changePassword(var pdata);
  Future<Either<ApiError, String>> changeUserInfo(var pdata);
}

final editProfileRepositoryProvider = Provider<EditProfileRepository>((ref) {
  return EditProfileRepositoryImpl(ref.read(editProfileDataSourceProvider));
});

class EditProfileRepositoryImpl extends EditProfileRepository {
  final EditProfileDataSource _editProfileDataSource;

  EditProfileRepositoryImpl(this._editProfileDataSource);

  @override
  Future<Either<ApiError, String>> changePassword(var pdata) async {
    try {
      final result = await _editProfileDataSource.changePassword(pdata);
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiError(message: e.message!));
    }
  }

  @override
  Future<Either<ApiError, String>> changeUserInfo(pdata) async {
    try {
      final result = await _editProfileDataSource.changeUserInfo(pdata);
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiError(message: e.message!));
    }
  }
}
