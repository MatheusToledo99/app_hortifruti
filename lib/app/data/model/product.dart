class ProductModel {
  int id;
  String name;
  String? description;
  String? image;
  double price;
  String unit;

  bool get isKG => unit == 'KG' || unit == 'kg';

  ProductModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.price,
    required this.unit,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['nome'],
        price: double.parse(json['preco']),
        image: json['imagem'],
        description: json['descricao'],
        unit: json['unidade'],
      );
}
