class CategoryModel {
  final int? id;
  final String? name;
  final String? image;
  final String? createdAt;
  final bool? isCollar;
  CategoryModel({this.id, this.createdAt, this.name, this.image, this.isCollar});

  factory CategoryModel.fromJson(Map<dynamic, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'] ?? 'Aman',
      image: json['image'] ?? 'Aman',
      isCollar: json['is_collar'] ?? false,
      createdAt: json['created_at'] ?? 'Aman',
    );
  }
}
