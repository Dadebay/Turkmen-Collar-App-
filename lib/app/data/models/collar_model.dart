// ignore_for_file: unnecessary_null_comparison

class CollarModel {
  final int? id;
  final String? name;
  final String? description;
  final int? price;
  final String? machineName;
  final String? createdAt;
  final int? views;
  final int? downloads;
  final List? images;
  final List<FilesModel>? files;
  final String? category;
  CollarModel({
    this.name,
    this.category,
    this.description,
    this.price,
    this.machineName,
    this.views,
    this.downloads,
    this.images,
    this.files,
    this.id,
    this.createdAt,
  });

  factory CollarModel.fromJson(Map<dynamic, dynamic> json) {
    final List image = json['images'] as List;
    List<dynamic> images = [];
    if (image == null) {
      images = [''];
    } else {
      images = image.map((value) => value).toList();
    }
    String categoryName = '';
    if (json['category'] != null) {
      categoryName = json['category']['name'];
    } else {
      categoryName = '';
    }
    return CollarModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      description: json['description'],
      price: json['price'],
      machineName: json['machine_name'],
      views: json['views'],
      downloads: json['downloads'],
      files: (json['files'] as List).map((json) => FilesModel.fromJson(json)).toList(),
      images: images,
      category: categoryName,
    );
  }
}

class FilesModel {
  int? price;
  String? name;
  String? machineName;
  List? machineImage;
  bool? purchased;
  int? id;

  FilesModel({this.name, this.machineImage, this.purchased, this.price, this.machineName, this.id});

  factory FilesModel.fromJson(Map<String, dynamic> json) {
    final List image = json['machine']['images'] as List;
    List<dynamic> images = [];
    if (image == null) {
      images = [''];
    } else {
      images = image.map((value) => value).toList();
    }
    return FilesModel(
      machineName: json['machine']['name'],
      machineImage: images,
      purchased: json['purchased'],
      price: json['price'],
      name: json['name'],
      id: json['id'],
    );
  }
}
