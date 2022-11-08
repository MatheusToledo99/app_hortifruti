// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_hortifruti/app/data/model/address.dart';
import 'package:app_hortifruti/app/data/model/cart_product.dart';
import 'package:app_hortifruti/app/data/model/payment.dart';
import 'package:app_hortifruti/app/data/model/store.dart';

class OrderModel {
  StoreModel store;
  PaymentModel payment;
  List<CartProductModel> cartProducts;
  AddressModel address;
  String? observation;
  double? moneyFor;

  OrderModel({
    required this.store,
    required this.payment,
    required this.cartProducts,
    required this.address,
    this.observation,
    this.moneyFor,
  });

  Map<String, dynamic> toJson() => {
        'estabelecimento_id': store.id,
        'meio_pagamento_id': payment.id,
        'endereco_id': address.id,
        'produtos':
            cartProducts.map((cartProduct) => cartProduct.toJson()).toList(),
        'observacao': observation,
        'troco_para': moneyFor,
      };
}
