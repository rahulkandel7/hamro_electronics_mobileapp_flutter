class Shipping {
  final int id;
  final String name;
  final int price;

  Shipping({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Shipping.fromMap(Map<String, dynamic> map) {
    return Shipping(
      id: map['id'] as int,
      name: map['area_name'] as String,
      price: int.parse(map['price']),
    );
  }
}
