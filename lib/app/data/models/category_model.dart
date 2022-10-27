class CategoryModel {
  final int? id;
  final String? name_tm;
  final String? name_ru;
  CategoryModel({
    this.id,
    this.name_tm,
    this.name_ru,
  });

  factory CategoryModel.fromJson(Map<dynamic, dynamic> json) {
    return CategoryModel(id: json['id'], name_tm: json['name_tm'], name_ru: json['name_ru']);
  }
}
