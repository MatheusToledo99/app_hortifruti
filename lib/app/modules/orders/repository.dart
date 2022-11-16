import 'package:app_hortifruti/app/data/model/order.dart';
import 'package:app_hortifruti/app/data/provider/api.dart';

class OrdersRepository {
  final Api _api;

  OrdersRepository(this._api);

  Future<List<OrderModel>> getOrders() {
    return _api.getOrders();
  }
}
