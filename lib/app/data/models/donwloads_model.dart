// ignore_for_file: unnecessary_null_comparison

import 'collar_model.dart';

class DownloadsModel {
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
  DownloadsModel({
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

  factory DownloadsModel.fromJson(Map<dynamic, dynamic> json) {
    final List image = json['images'] as List;
    List<dynamic> images = [];
    if (image == null) {
      images = [''];
    } else {
      images = image.map((value) => value).toList();
    }
    return DownloadsModel(
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
      category: json['category']['name'],
    );
  }
}
