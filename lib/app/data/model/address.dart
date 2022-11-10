// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_hortifruti/app/data/model/city.dart';

class AddressModel {
  int? id;
  String street;
  String? number;
  String district;
  String? referencePoint;
  String? complement;
  CityModel? city;

  AddressModel({
    this.id,
    required this.street,
    this.number,
    required this.district,
    this.referencePoint,
    this.complement,
    this.city,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'],
        street: json['rua'],
        number: json['numero'],
        district: json['bairro'],
        referencePoint: json['ponto_referencia'],
        complement: json['complemento'],
        city:
            json['cidade'] != null ? CityModel.fromJson(json['cidade']) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cidadeId': city!.id,
        'rua': street,
        'numero': number,
        'bairro': district,
        'pontoReferencia': referencePoint,
        'complemento': complement,
      };

  @override
  String toString() {
    number ?? (number = '');
    city?.name ?? (city?.name = '');
    referencePoint ?? (referencePoint = '');
    complement ?? (complement = '');

    return 'Rua: $street \nBairro: $district \nCidade: ${city!.name} \nNúmero: $number \nReferência: $referencePoint \nComplemento: $complement';
  }
}
