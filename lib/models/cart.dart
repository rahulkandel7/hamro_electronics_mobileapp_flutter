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
}
