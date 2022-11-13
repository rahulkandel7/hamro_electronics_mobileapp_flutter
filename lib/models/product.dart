class Product {
  int id;
  String name;
  String sku;
  int categoryId;
  int brandId;
  int subCategoryId;
  String description;
  int price;
  String color;
  String size;
  String photopath1;
  String photopath2;
  String photopath3;
  int status;
  int stock;
  int discountedprice;
  int flashsale;
  int deleted;
  double? rating;
  int ratingNumber;
  Product({
    required this.brandId,
    required this.categoryId,
    required this.color,
    required this.deleted,
    required this.description,
    required this.discountedprice,
    required this.flashsale,
    required this.id,
    required this.name,
    required this.photopath1,
    required this.photopath2,
    required this.photopath3,
    required this.price,
    required this.size,
    required this.sku,
    required this.status,
    required this.stock,
    required this.subCategoryId,
    required this.rating,
    required this.ratingNumber,
  });
}
