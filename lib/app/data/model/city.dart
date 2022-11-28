// ignore_for_file: public_member_api_docs, sort_constructors_first
class CityModel {
  int id;
  String name;
  String uf;

  CityModel({
    required this.id,
    required this.name,
    required this.uf,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json['id'],
        name: json['nome'],
        uf: json['estado']['uf'],
      );

  @override
  String toString() => 'id: $id, name: $name, uf: $uf';
}
