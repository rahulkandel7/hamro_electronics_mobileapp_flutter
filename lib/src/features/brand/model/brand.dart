class Brand {
  int id;
  String brandName;

  Brand({
    required this.id,
    required this.brandName,
  });

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map['id'] as int,
      brandName: map['brand_name'] as String,
    );
  }
}
