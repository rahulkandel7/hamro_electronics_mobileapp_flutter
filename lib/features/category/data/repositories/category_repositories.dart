import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_error.dart';
import 'package:hamro_electronics/features/category/data/data_sources/category_data_sources.dart';
import 'package:hamro_electronics/features/category/data/models/Category.dart';

abstract class CategoryRepository {
  Future<Either<ApiError, List<Category>>> getCategory();
}

final categoryRepoProvider = Provider<CategoryRepositoryImpl>((ref) {
  return CategoryRepositoryImpl(ref.read(categoryDataSourceProvider));
});

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDataSource _categoryDataSource;

  CategoryRepositoryImpl(this._categoryDataSource);
  @override
  Future<Either<ApiError, List<Category>>> getCategory() async {
    try {
      final result = await _categoryDataSource.getCategory();
      return Right(result);
    } on DioError catch (e) {
      return Left(ApiError(message: e.message));
    }
  }
}
