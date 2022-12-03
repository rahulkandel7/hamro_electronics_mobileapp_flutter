// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Category {
  final int id;
  final String categoryName;
  final int priority;
  final String photopath;

  Category({
    required this.categoryName,
    required this.id,
    required this.photopath,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category_name': categoryName,
      'priority': priority,
      'photopath': photopath,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      categoryName: map['category_name'] as String,
      priority: int.parse(map['priority']),
      photopath: map['photopath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
