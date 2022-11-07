import 'package:app_hortifruti/app/data/model/product.dart';

class CategoryModel {
  int id;
  String name;
  String? description;
  List<ProductModel> products;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    required this.products,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      id: json['id'],
      name: json['nome'],
      description: json['descricao'],
      products: json['produtos'] == null
          ? []
          : List<ProductModel>.from(
              json['produtos']
                  .map((thisProduct) => ProductModel.fromJson(thisProduct)),
            ));
}
