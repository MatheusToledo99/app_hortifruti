// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_hortifruti/app/data/model/order_detail.dart';
import 'package:app_hortifruti/app/data/model/payment.dart';
import 'package:app_hortifruti/app/data/model/status.dart';
import 'package:app_hortifruti/app/data/model/store.dart';

class OrderModel {
  String hashId;
  StoreModel store;
  List<StatusModel> statuses;
  double value;
  double deliveryCoast;
  DateTime createAt;
  PaymentModel? payment;
  List<OrderDetailModel>? orderDetail;

  OrderModel({
    required this.hashId,
    required this.store,
    required this.statuses,
    required this.value,
    required this.deliveryCoast,
    required this.createAt,
    this.payment,
    this.orderDetail,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        hashId: json['hash_id'],
        store: StoreModel.fromJson(json['estabelecimento']),
        statuses: json['pedido_status'] == null
            ? []
            : List<StatusModel>.from(
                json['pedido_status']
                    .map((thisStatus) => StatusModel.fromJson(thisStatus)),
              ),
        value: double.parse(json['valor']),
        deliveryCoast: double.parse(json['custo_entrega']),
        createAt: DateTime.parse(json['created_at']),
        payment: json['meioPagamento'] == null
            ? null
            : PaymentModel.fromJson(json['meioPagamento']),
        orderDetail: json['pedidosProduto'] == null
            ? []
            : List<OrderDetailModel>.from(
                json['pedidosProduto'].map(
                    (thisProduct) => OrderDetailModel.fromJson(thisProduct)),
              ),
      );
}
