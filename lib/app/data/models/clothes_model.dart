// ignore_for_file: unnecessary_null_comparison

class DressesModel {
  final int? id;
  final String? name;
  // final String? description;
  // final String? barcode;
  final int? price;
  // final int? views;
  final String? createdAt;

  final String? image;
  // final String? category;
  DressesModel({
    this.name,
    this.createdAt,
    // this.barcode,
    // this.category,
    // this.description,
    this.price,
    // this.views,
    this.image,
    this.id,
  });

  factory DressesModel.fromJson(Map<dynamic, dynamic> json) {
    return DressesModel(
      id: json['id'],
      createdAt: json['created_at'] ?? 'null',
      // barcode: json['barcode'] ?? 'null',
      name: json['name'] ?? 'null',
      // description: json['description'] ?? 'null',
      price: json['price'] ?? 0,
      // views: json['views'] ?? 0,
      // category: json['category'] ?? 'null',
      image: json['image'] ?? 'null',
    );
  }
}

class DressesModelFavorites {
  final int? id;
  final String? name;
  final String? description;
  final String? barcode;
  final int? price;
  final int? views;
  final String? createdAt;
  final String? image;
  DressesModelFavorites({
    this.name,
    this.createdAt,
    this.barcode,
    this.description,
    this.price,
    this.views,
    this.image,
    this.id,
  });

  factory DressesModelFavorites.fromJson(Map<dynamic, dynamic> json) {
    return DressesModelFavorites(
      id: json['id'],
      name: json['name'] ?? 'null',
      description: json['description'] ?? 'null',
      price: json['price'] ?? 0,
      views: json['views'] ?? 0,
      barcode: json['barcode'] ?? 'null',
      createdAt: json['created_at'],
      image: json['images'][0],
    );
  }
}

class DressesModelByID {
  final int? id;
  final String? name;
  final String? description;
  final String? barcode;
  final int? price;
  final int? views;
  final String? createdAt;

  final List? images;
  final String? category;
  DressesModelByID({
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

  factory DressesModelByID.fromJson(Map<String, dynamic> json) {
    final List image = json['images'] as List;
    List<dynamic> images = [];
    if (image == null) {
      images = [''];
    } else {
      images = image.map((value) => value).toList();
    }
    return DressesModelByID(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Ady',
      description: json['description'] ?? 'mazmuny',
      barcode: json['barcode'] ?? 'barcode',
      price: json['price'] ?? 0,
      views: json['views'] ?? 0,
      images: images,
      createdAt: json['created_at'] ?? DateTime.now(),
      category: json['category'] ?? 'kategoriya',
    );
  }
}
