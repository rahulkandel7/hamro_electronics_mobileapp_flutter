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
}
