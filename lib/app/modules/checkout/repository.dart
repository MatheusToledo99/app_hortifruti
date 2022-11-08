// ignore_for_file: unused_field

import 'package:app_hortifruti/app/data/model/address.dart';
import 'package:app_hortifruti/app/data/model/order.dart';
import 'package:app_hortifruti/app/data/provider/api.dart';

class CheckoutRepository {
  final Api _api;

  CheckoutRepository(this._api);

  Future<List<AddressModel>> getUserAddress() {
    return _api.getUserAddress();
  }

  Future postOrder(OrderModel order) {
    return _api.postOrder(order);
  }
}
