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

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      categoryName: map['category_name'] as String,
      priority: int.parse(map['priority']),
      photopath: map['photopath'] as String,
    );
  }
}
