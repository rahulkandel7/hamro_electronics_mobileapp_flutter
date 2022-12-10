// ignore_for_file: public_member_api_docs, sort_constructors_first

class Cart {
  final int id;
  final int productId;
  final int quantity;
  final String color;
  final String size;
  final int price;
  final int userId;
  final String status;
  final int ordered;

  Cart({
    required this.id,
    required this.productId,
    required this.userId,
    required this.quantity,
    required this.color,
    required this.size,
    required this.status,
    required this.ordered,
    required this.price,
  });

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] as int,
      productId: int.parse(map['product_id']),
      quantity: int.parse(map['quantity']),
      color: map['color'] as String,
      size: map['size'] as String,
      price: int.parse(map['price']),
      userId: int.parse(map['user_id']),
      status: map['status'] as String,
      ordered: int.parse(map['ordered']),
    );
  }
}
