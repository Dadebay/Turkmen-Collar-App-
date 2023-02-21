class CategoryModel {
  final int? id;
  final String? name;
  final String? image;
  final String? createdAt;
  CategoryModel({
    this.id,
    this.createdAt,
    this.name,
    this.image,
  });

  factory CategoryModel.fromJson(Map<dynamic, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'] ?? 'Aman',
      image: json['image'] ?? 'Aman',
      createdAt: json['created_at'] ?? 'Aman',
    );
  }
}
