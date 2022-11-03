// ignore_for_file: unnecessary_null_comparison

class CollarModel {
  final int? id;
  final String? name;
  final String? description;
  final int? price;
  final String? machineName;
  final int? views;
  final int? downloads;
  final List? images;
  final List? files;
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
  });

  factory CollarModel.fromJson(Map<dynamic, dynamic> json) {
    final List image = json['images'] as List;
    List<dynamic> images = [];
    if (image == null) {
      images = [''];
    } else {
      images = image.map((value) => value).toList();
    }
    print(json['category']);
    return CollarModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      machineName: json['machine_name'],
      views: json['views'],
      downloads: json['downloads'],
      files: json['files'],
      images: images,
      category: json['category']['name'],
    );
  }
}

// class CategoryModel2 {
//   String? image;
//   String? name;
//   int? id;

//   CategoryModel2({this.name, this.image, this.id});

//   CategoryModel2.fromJson(Map<String, dynamic> json) {
//     print(json['image']);
//     name = json['image'];
//     name = json['name'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['image'] = image;
//     data['name'] = name;
//     data['id'] = id;
//     return data;
//   }
// }
