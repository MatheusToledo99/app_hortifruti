import 'package:app_hortifruti/app/data/model/product.dart';

class OrderDetailModel {
  ProductModel product;
  double quantity;
  String? observation;

  OrderDetailModel({
    required this.product,
    required this.quantity,
    this.observation,
  });
  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        product: ProductModel.fromJson(json['produto']),
        quantity: double.parse(json['quantidade']),
        observation: json['observation'],
      );
}
