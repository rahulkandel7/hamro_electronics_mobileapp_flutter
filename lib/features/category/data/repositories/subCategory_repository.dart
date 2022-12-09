import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_error.dart';
import 'package:hamro_electronics/features/category/data/data_sources/sub_category_data_source.dart';
import 'package:hamro_electronics/features/category/data/models/subCategory.dart';

abstract class SubCategoryRepository {
  Future<Either<ApiError, List<SubCategory>>> getSubCategory();
}

final subCategoryRepositoryProvider =
    Provider<SubCategoryRepositoryImpl>((ref) {
  return SubCategoryRepositoryImpl(ref.read(subCategoryDataSourceProvider));
});

class SubCategoryRepositoryImpl extends SubCategoryRepository {
  final SubCategoryDataSource _subCategoryDataSource;

  SubCategoryRepositoryImpl(this._subCategoryDataSource);
  @override
  Future<Either<ApiError, List<SubCategory>>> getSubCategory() async {
    try {
      final result = await _subCategoryDataSource.getSubCategory();
      return Right(result);
    } on DioError catch (e) {
      return Left(ApiError(message: e.message));
    }
  }
}
