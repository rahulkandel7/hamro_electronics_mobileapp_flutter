class SubCategory {
  int id;
  String subCategoryName;
  int priority;
  int categoryId;

  SubCategory({
    required this.categoryId,
    required this.id,
    required this.priority,
    required this.subCategoryName,
  });

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      id: map['id'] as int,
      subCategoryName: map['subcategory_name'] as String,
      priority: int.parse(map['priority']),
      categoryId: int.parse(map['category_id']),
    );
  }
}
