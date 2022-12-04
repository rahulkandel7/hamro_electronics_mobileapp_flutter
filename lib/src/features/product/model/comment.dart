class Comment {
  final int id;
  final String comment;
  final int productId;
  final int userId;
  final String userName;
  final String date;

  Comment({
    required this.id,
    required this.comment,
    required this.productId,
    required this.userId,
    required this.userName,
    required this.date,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as int,
      comment: map['comment'] as String,
      productId: int.parse(map['product_id']),
      userId: int.parse(map['user_id']),
      userName: map['user_name'] ?? '',
      date: map['created_at'] as String,
    );
  }
}
