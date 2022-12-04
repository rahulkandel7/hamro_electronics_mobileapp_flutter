class Wishlist {
  final int id;
  final int productId;

  Wishlist({
    required this.id,
    required this.productId,
  });

  factory Wishlist.fromMap(Map<String, dynamic> map) {
    return Wishlist(
      id: map['id'] as int,
      productId: int.parse(map['product_id']),
    );
  }
}
