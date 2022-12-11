import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/product_view/data/models/comment.dart';
import 'package:hamro_electronics/features/product_view/data/repositories/comment_repository.dart';

class CommentController extends StateNotifier<AsyncValue<List<Comment>>> {
  CommentController(this._commentRepository) : super(const AsyncLoading());
  final CommentRepository _commentRepository;
  fetchComments(int id) async {
    final result = await _commentRepository.getComments(id);
    result.fold(
        (error) => state =
            AsyncError(error.message, StackTrace.fromString(error.toString())),
        (success) => state = AsyncData(success));
  }
}

final commentControllerProvider =
    StateNotifierProvider<CommentController, AsyncValue<List<Comment>>>((ref) {
  return CommentController(ref.watch(commentRepositoryProvider));
});
