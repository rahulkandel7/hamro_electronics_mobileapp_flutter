import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_error.dart';
import '../data_sources/brand_data_sources.dart';
import '../models/brand.dart';

abstract class BrandRepository {
  Future<Either<ApiError, List<Brand>>> getBrand();
}

final brandRepositoryProvider = Provider<BrandRepository>((ref) {
  return BrandRepositoryImpl(ref.read(brandDataSourceProvider));
});

class BrandRepositoryImpl extends BrandRepository {
  final BrandDataSource _brandDataSource;

  BrandRepositoryImpl(this._brandDataSource);
  @override
  Future<Either<ApiError, List<Brand>>> getBrand() async {
    try {
      final result = await _brandDataSource.getBrand();
      return Right(result);
    } on DioError catch (e) {
      return Left(
        ApiError(
          message: e.toString(),
        ),
      );
    }
  }
}
