class HistoryOderModel {
  HistoryOderModel({this.id, this.totalPrice, this.createdAT, this.name, this.coupon, this.address, this.discountValue});

  factory HistoryOderModel.fromJson(Map<dynamic, dynamic> json) {
    return HistoryOderModel(
      id: json['id'],
      totalPrice: json['total_price'],
      createdAT: json['created_at'],
      name: json['name'],
      coupon: json['coupon'] ?? '0',
      discountValue: json['discount_value'] ?? 0,
      address: json['address'] ?? '0',
    );
  }
  final int? id;
  final String? totalPrice;
  final String? createdAT;
  final String? name;
  final String? coupon;
  final int? discountValue;
  final String? address;
}
