class AboutUsModel {
  final String? phone;
  final int? id;
  final String? email;
  final String? addressTM;
  final String? addressRu;
  AboutUsModel({
    this.phone,
    this.email,
    this.id,
    this.addressRu,
    this.addressTM,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(phone: json['phone'] as String, email: json['email'] as String, addressTM: json['addressTM'] as String, addressRu: json['addressRu'] as String, id: json['id'] as int);
  }
}
