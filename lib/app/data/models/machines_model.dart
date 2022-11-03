class MachineModel {
  final int? id;
  final int? price;
  final int? views;
  final String? name;
  final List? images;

  final String? description;
  MachineModel({
    this.id,
    this.name,
    this.description,
    this.images,
    this.price,
    this.views,
  });

  factory MachineModel.fromJson(Map<dynamic, dynamic> json) {
    final List image = json['images'] as List;
    List<dynamic> images = [];
    if (image == null) {
      images = [''];
    } else {
      images = image.map((value) => value).toList();
    }
    return MachineModel(
      id: json['id'],
      name: json['name'],
      images: images,
      views: json['views'],
      description: json['description'],
      price: json['price'],
    );
  }
}
