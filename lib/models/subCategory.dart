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
}
