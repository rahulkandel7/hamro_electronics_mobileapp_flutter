// ignore_for_file: public_member_api_docs, sort_constructors_first

class Coupon {
  final int id;
  final String name;
  final int isAvailable;
  final int isAmoount;
  final int offerAmount;
  final int isPercent;
  final int offerPercent;
  final int maxDisAmount;
  final int minAmount;

  Coupon({
    required this.id,
    required this.isAmoount,
    required this.isAvailable,
    required this.isPercent,
    required this.maxDisAmount,
    required this.minAmount,
    required this.name,
    required this.offerAmount,
    required this.offerPercent,
  });

  factory Coupon.fromMap(Map<String, dynamic> map) {
    return Coupon(
      id: map['id'] as int,
      name: map['name'] as String,
      isAvailable: int.parse(map['isAvailable']),
      isAmoount: int.parse(map['isAmount']),
      offerAmount: int.parse(map['offerAmount']),
      isPercent: int.parse(map['isPercent']),
      offerPercent: int.parse(map['offerPercent']),
      maxDisAmount: int.parse(map['maxDisAmount']),
      minAmount: int.parse(map['minAmount']),
    );
  }
}
