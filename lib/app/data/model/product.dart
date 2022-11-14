class ProductModel {
  int id;
  String name;
  String? description;
  String? image;
  double price;
  String unit;
  double? quantityOrder;

  bool get isKG => unit == 'KG' || unit == 'kg';

  ProductModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.price,
    required this.unit,
    this.quantityOrder,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['nome'],
        price: double.parse(json['preco']),
        image: json['imagem'],
        description: json['descricao'],
        unit: json['unidade'],
      );

  factory ProductModel.fromJsonOrder(Map<String, dynamic> json) {
    return ProductModel(
      id: json['produto']['id'],
      name: json['produto']['nome'],
      price: double.parse(json['produto']['preco']),
      image: json['produto']['imagem'],
      description: json['produto']['descricao'],
      unit: json['produto']['unidade'],
      quantityOrder: double.parse(json['quantidade']),
    );
  }
}
