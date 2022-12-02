import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/comment.dart';

class CommentController extends StateNotifier<List<Comment>> {
  CommentController(super.state);

  String url = 'https://api.hamroelectronics.com.np/api/v1/';

  Future<List<Comment>> fetchComment(id) async {
    final response = await http.get(
      Uri.parse('${url}product/view/$id'),
    );

    final extractedData = json.decode(response.body);

    if (response.statusCode == 200) {
      final comments = extractedData['comments'] as List<dynamic>;
      state.cast();
      for (var comment in comments) {
        state.add(
          Comment(
            id: comment['id'],
            comment: comment['comment'],
            productId: int.parse(comment['product_id']),
            userId: int.parse(comment['user_id']),
            userName: comment['user_name'] ?? '',
            date: comment['created_at'],
          ),
        );
      }
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
