import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_error.dart';
import 'package:hamro_electronics/features/auth/data/data_sources/auth_data_sources.dart';

abstract class AuthRepository {
  Future<Either<ApiError, void>> login(var pdata);
  Future<Either<ApiError, void>> register(var pdata);
  Future<Either<ApiError, void>> logout();
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authDataSourceProvider));
});

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSources _authDataSources;
  AuthRepositoryImpl(this._authDataSources);
  @override
  Future<Either<ApiError, void>> login(var pdata) async {
    try {
      final result = await _authDataSources.login(pdata);

      return Right(result);
    } on DioError catch (e) {
      return Left(
        ApiError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, void>> logout() async {
    try {
      final result = await _authDataSources.logout();
      return Right(result);
    } on DioError catch (e) {
      return Left(
        ApiError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, void>> register(pdata) async {
    try {
      final result = await _authDataSources.register(pdata);
      return Right(result);
    } on DioError catch (e) {
      print(e.error);
      return Left(
        ApiError(
          message: e.type.toString(),
        ),
      );
    }
  }
}
