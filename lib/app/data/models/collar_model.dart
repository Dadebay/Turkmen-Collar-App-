// ignore_for_file: unnecessary_null_comparison

class CollarModel {
  final int? id;
  final String? name;
  final int? price;
  final String? createdAt;
  final String? image;
  CollarModel({
    this.name,
    this.price,
    this.image,
    this.id,
    this.createdAt,
  });

  factory CollarModel.fromJson(Map<dynamic, dynamic> json) {
    return CollarModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      createdAt: json['created_at'] ?? DateTime.now(),
      price: json['price'] ?? 0,
      image: json['thumb'] ?? '',
    );
  }

  List? get images => null;
}

class CollarByIDModel {
  final int? id;
  final String? name;
  final String? desc;
  final int? price;
  final int? views;
  final int? downloads;
  final String? tag;
  final String? machineName;
  final String? createdAt;
  final List? images;
  final List<FilesModel>? files;

  CollarByIDModel({
    this.id,
    this.name,
    this.desc,
    this.price,
    this.views,
    this.downloads,
    this.tag,
    this.machineName,
    this.createdAt,
    this.images,
    this.files,
  });

  factory CollarByIDModel.fromJson(Map<dynamic, dynamic> json) {
    final List image = json['images'] as List;
    List<dynamic> images = [];
    if (image == null) {
      images = [''];
    } else {
      images = image.map((value) => value).toList();
    }
    return CollarByIDModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      desc: json['description'] ?? '',
      views: json['views'] ?? 0,
      downloads: json['downlaods'] ?? 0,
      price: json['price'] ?? 0,
      tag: json['tag'] ?? '',
      machineName: json['machine_name'] ?? '',
      createdAt: json['created_at'] ?? DateTime.now(),
      images: images,
      files: (json['files'] as List).map((json) => FilesModel.fromJson(json)).toList(),
    );
  }
}

class FilesModel {
  int? id;

  int? price;
  String? machineLogo;
  String? createtdAt;
  List? images;
  bool? purchased;
  String? machineName;

  FilesModel({this.id, this.price, this.machineLogo, this.createtdAt, this.images, this.purchased, this.machineName});

  factory FilesModel.fromJson(Map<String, dynamic> json) {
    final List image = json['images'] as List;
    List<dynamic> images = [];
    if (image == null) {
      images = [''];
    } else {
      images = image.map((value) => value).toList();
    }
    return FilesModel(
      id: json['id'] ?? 0,
      price: json['price'] ?? 0,
      machineLogo: json['machine_thumb'] ?? '',
      createtdAt: json['created_at'],
      images: images,
      purchased: json['purchased'] ?? false,
      machineName: json['machine_name'] ?? 'Ady',
    );
  }
}
