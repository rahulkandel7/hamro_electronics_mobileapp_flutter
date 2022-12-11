// ignore_for_file: public_member_api_docs, sort_constructors_first

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

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      sku: map['sku'] as String,
      categoryId: int.parse(map['category_id']),
      brandId: int.parse(map['brand_id']),
      subCategoryId: int.parse(map['sub_category_id'] ?? 0.toString()),
      description: map['description'] as String,
      price: int.parse(map['price']),
      color: map['color'] as String,
      size: map['size'] as String,
      photopath1: map['photopath1'] as String,
      photopath2: map['photopath2'] ?? '',
      photopath3: map['photopath3'] ?? '',
      status: int.parse(map['available']),
      stock: int.parse(map['stock']),
      discountedprice: int.parse(map['discountedprice'] ?? 0.toString()),
      flashsale: int.parse(map['flashsale']),
      deleted: int.parse(map['deleted']),
      rating: double.tryParse(map['rating'].toString()),
      ratingNumber: map['rating_number'] as int,
    );
  }
}
