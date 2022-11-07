// ignore_for_file: public_member_api_docs, sort_constructors_first
class CityCostModel {
  int id;
  String name;
  double cost;

  CityCostModel({
    required this.id,
    required this.name,
    required this.cost,
  });

  factory CityCostModel.fromJson(Map<String, dynamic> json) => CityCostModel(
        id: json['id'],
        name: json['cidade'],
        cost: double.parse(json['custo_entrega']),
      );
}
