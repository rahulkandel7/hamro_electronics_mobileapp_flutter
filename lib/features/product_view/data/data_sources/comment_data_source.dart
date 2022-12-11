import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/core/api/api_service.dart';
import 'package:hamro_electronics/features/product_view/data/models/comment.dart';

abstract class CommentDataSource {
  Future<List<Comment>> getComments(int id);
}

final commentDataSourceProvider = Provider<CommentDataSource>((ref) {
  return CommentDataSourceImpl(ref.read(apiServiceProvider));
});

class CommentDataSourceImpl extends CommentDataSource {
  final ApiService _apiService;

  CommentDataSourceImpl(this._apiService);
  @override
  Future<List<Comment>> getComments(int id) async {
    final result = await _apiService.getData(endpoint: 'product/view/$id');
    final comments = result['comments'] as List<dynamic>;

    return comments.map((comment) => Comment.fromMap(comment)).toList();
  }
}
