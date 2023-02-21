// ignore_for_file: unnecessary_null_comparison

class MachineModel {
  final int? id;
  final int? price;
  final int? views;
  final String? createdAt;
  final String? name;
  final String? images;

  final String? description;
  MachineModel({
    this.id,
    this.name,
    this.createdAt,
    this.description,
    this.images,
    this.price,
    this.views,
  });

  factory MachineModel.fromJson(Map<dynamic, dynamic> json) {
    return MachineModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      images: json['thumb'],
      views: json['views'],
      description: json['description'],
      price: json['price'],
    );
  }
}
