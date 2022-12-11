import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_error.dart';
import 'package:hamro_electronics/core/api/dio_exception.dart';
import 'package:hamro_electronics/features/product_view/data/data_sources/comment_data_source.dart';
import 'package:hamro_electronics/features/product_view/data/models/comment.dart';

abstract class CommentRepository {
  Future<Either<ApiError, List<Comment>>> getComments(int id);
}

final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  return CommentRepositoryImpl(ref.read(commentDataSourceProvider));
});

class CommentRepositoryImpl extends CommentRepository {
  final CommentDataSource _commentDataSource;
  CommentRepositoryImpl(this._commentDataSource);

  @override
  Future<Either<ApiError, List<Comment>>> getComments(int id) async {
    try {
      final result = await _commentDataSource.getComments(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiError(message: e.message!));
    }
  }
}
