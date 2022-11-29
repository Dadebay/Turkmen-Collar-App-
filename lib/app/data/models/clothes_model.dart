// ignore_for_file: unnecessary_null_comparison

class DressesModel {
  final int? id;
  final String? name;
  final String? description;
  final String? barcode;
  final int? price;
  final int? views;
  final String? createdAt;

  final List? images;
  final String? category;
  DressesModel({
    this.name,
    this.createdAt,
    this.barcode,
    this.category,
    this.description,
    this.price,
    this.views,
    this.images,
    this.id,
  });

  factory DressesModel.fromJson(Map<dynamic, dynamic> json) {
    final List image = json['images'] as List;
    List<dynamic> images = [];
    if (image == null) {
      images = [''];
    } else {
      images = image.map((value) => value).toList();
    }

    return DressesModel(
      id: json['id'],
      createdAt: json['created_at'],
      name: json['name'],
      barcode: json['barcode'],
      description: json['description'],
      price: json['price'],
      views: json['views'],
      category: json['category']['name'],
      images: images,
    );
  }
}
