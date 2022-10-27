class BannerModel {
  final int? id;
  final String? image;
  final String? title;
  BannerModel({
    this.id,
    this.image,
    this.title,
  });

  factory BannerModel.fromJson(Map<dynamic, dynamic> json) {
    return BannerModel(
      id: json['id'],
      image: json['image'],
      title: json['title'],
    );
  }
}
