import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../model/comment.dart';

class CommentController extends StateNotifier<List<Comment>> {
  CommentController(super.state);

  Future<List<Comment>> fetchComment(id) async {
    final response = await http.get(
      Uri.parse('${Constants.API}product/view/$id'),
    );

    if (response.statusCode == 200) {
      final comments = jsonDecode(response.body)['comments'] as List<dynamic>;
      state.clear();
      state = comments.map((comment) => Comment.fromMap(comment)).toList();
    }

    return state;
  }
}

var commentProvider =
    StateNotifierProvider.autoDispose<CommentController, List<Comment>>((ref) {
  return CommentController([]);
});

var fetchComment =
    FutureProvider.autoDispose.family<List<Comment>, int>((ref, id) {
  return ref.watch(commentProvider.notifier).fetchComment(id);
});
