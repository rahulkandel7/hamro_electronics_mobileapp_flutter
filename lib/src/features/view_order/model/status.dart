class Status {
  final int id;
  final int productId;
  final String productName;
  final String productPhoto;
  final String size;
  final String color;
  final int quantity;
  final String status;
  final String reason;

  Status({
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
}
