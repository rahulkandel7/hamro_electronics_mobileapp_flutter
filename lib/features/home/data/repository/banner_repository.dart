import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_error.dart';
import 'package:hamro_electronics/features/home/data/data_source/banner_data_source.dart';
import 'package:hamro_electronics/features/home/data/model/banner.dart';

abstract class BannerRepository {
  Future<Either<ApiError, List<Banner>>> getBanner();
}

final bannerRepositoryProvider = Provider<BannerRepositoryImpl>((ref) {
  return BannerRepositoryImpl(ref.read(bannerDataSourceProvider));
});

class BannerRepositoryImpl extends BannerRepository {
  final BannerDataSource _bannerDataSource;

  BannerRepositoryImpl(this._bannerDataSource);
  @override
  Future<Either<ApiError, List<Banner>>> getBanner() async {
    try {
      final result = await _bannerDataSource.getBanner();
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
