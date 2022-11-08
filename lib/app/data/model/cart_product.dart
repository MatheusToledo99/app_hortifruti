import 'package:app_hortifruti/app/data/model/product.dart';

class CartProductModel {
  ProductModel product;
  num quantity;
  String? observation;

  CartProductModel({
    required this.product,
    required this.quantity,
    this.observation,
  });

  num get total => product.price * quantity;

  Map<String, dynamic> toJson() => {
        'produto_id': product.id,
        'quantidade': quantity,
        'observacao': observation,
      };
}
