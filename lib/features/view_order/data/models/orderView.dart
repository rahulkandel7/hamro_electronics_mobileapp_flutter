// ignore_for_file: public_member_api_docs, sort_constructors_first

class OrderView {
  final int id;
  final int productId;
  final String productName;
  final String productPhoto;
  final String size;
  final String color;
  final int quantity;
  final String status;
  final String reason;

  OrderView({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPhoto,
    required this.color,
    required this.quantity,
    required this.reason,
    required this.size,
    required this.status,
  });

  factory OrderView.fromMap(Map<String, dynamic> map) {
    return OrderView(
      id: map['id'] as int,
      productId: int.parse(map['product_id']),
      productName: map['productname'] as String,
      productPhoto: map['photopath'] as String,
      size: map['size'] as String,
      color: map['color'] as String,
      quantity: int.parse(map['quantity']),
      status: map['status'] as String,
      reason: map['reason'] as String,
    );
  }
}
