class BannerModel {
  final int? id;
  final String? image;
  final String? url;
  BannerModel({
    this.id,
    this.image,
    this.url,
  });

  factory BannerModel.fromJson(Map<dynamic, dynamic> json) {
    return BannerModel(id: json['id'], image: json['image'], url: json['url']);
  }
}
