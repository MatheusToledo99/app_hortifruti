import 'package:app_hortifruti/app/data/model/order.dart';
import 'package:app_hortifruti/app/data/provider/api.dart';

class OrderDetailRepository {
  final Api _api;

  OrderDetailRepository(this._api);

  Future<OrderModel> getOrder(String hashId) {
    return _api.getOrder(hashId);
  }
}
