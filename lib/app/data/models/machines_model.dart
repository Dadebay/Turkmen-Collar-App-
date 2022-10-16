class MachineModel {
  final int? id;
  final String? name_tm;
  final String? name_ru;
  MachineModel({
    this.id,
    this.name_tm,
    this.name_ru,
  });

  factory MachineModel.fromJson(Map<dynamic, dynamic> json) {
    return MachineModel(id: json['id'], name_tm: json['name_tm'], name_ru: json['name_ru']);
  }
}
