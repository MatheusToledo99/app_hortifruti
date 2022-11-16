class StatusModel {
  String name;
  DateTime createAt;

  StatusModel({
    required this.name,
    required this.createAt,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        name: json['status']['status'],
        createAt: DateTime.parse(json['created_at']),
      );
}
