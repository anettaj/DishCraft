class StorageDataModel {
  final String instructions;
  final bool freezable;

  StorageDataModel({
    required this.instructions,
    required this.freezable,
  });

  factory StorageDataModel.fromJson(Map<String, dynamic> json) {
    return StorageDataModel(
      instructions: json['instructions'],
      freezable: json['freezable'],
    );
  }

}
