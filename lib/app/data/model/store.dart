// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_hortifruti/app/data/model/category.dart';
import 'package:app_hortifruti/app/data/model/city_cost.dart';
import 'package:app_hortifruti/app/data/model/payment.dart';

class StoreModel {
  int id;
  String name;
  String? image;
  bool isOnline;
  List<CategoryModel> categories;
  List<CityCostModel> cityCosts;
  List<PaymentModel> payment;

  StoreModel({
    required this.id,
    required this.name,
    this.image,
    required this.isOnline,
    required this.categories,
    required this.cityCosts,
    required this.payment,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json['id'],
        name: json['nome'],
        image: json['logo'],
        isOnline: json['online'] == 1,
        categories: json['categorias'] == null
            ? []
            : List<CategoryModel>.from(
                json['categorias'].map(
                  (thisCategories) => CategoryModel.fromJson(thisCategories),
                ),
              ),
        cityCosts: json['cidades'] == null
            ? []
            : List<CityCostModel>.from(
                json['cidades'].map(
                  (thisCity) => CityCostModel.fromJson(thisCity),
                ),
              ),
        payment: json['meios_pagamentos'] == null
            ? []
            : List<PaymentModel>.from(
                json['meios_pagamentos'].map(
                  (thisPayment) => PaymentModel.fromJson(thisPayment),
                ),
              ),
      );
}
