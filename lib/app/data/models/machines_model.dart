// ignore_for_file: unnecessary_null_comparison

class MachineModel {
  final int? id;
  final int? price;
  final String? createdAt;
  final String? name;
  final String? images;

  MachineModel({
    this.id,
    this.name,
    this.createdAt,
    this.images,
    this.price,
  });

  factory MachineModel.fromJson(Map<dynamic, dynamic> json) {
    return MachineModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      images: json['image'],
      createdAt: json['created_at'],
    );
  }
}
