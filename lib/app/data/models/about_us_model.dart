class AboutUsModel {
  final String? title;
  final String? body;
  AboutUsModel({
    this.title,
    this.body,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
