// ignore_for_file: unnecessary_null_comparison

class CollarModel {
  final int? id;
  final String? name;
  final int? price;
  final String? machineName;
  final String? createdAt;
  final bool? purchased;
  final String? file;
  CollarModel({this.name, this.price, this.machineName, this.id, this.createdAt, this.file, this.purchased});

  factory CollarModel.fromJson(Map<dynamic, dynamic> json) {
    final List image = json['images'] as List;
    List<dynamic> images = [];
    if (image == null) {
      images = [''];
    } else {
      images = image.map((value) => value).toList();
    }
    return CollarModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      price: json['price'],
      machineName: json['machine_name'],
      file: json['file'],
      purchased: json['purchased'],
    );
  }
}
