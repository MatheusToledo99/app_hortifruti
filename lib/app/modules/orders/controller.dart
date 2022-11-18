import 'package:app_hortifruti/app/data/model/order.dart';
import 'package:app_hortifruti/app/modules/orders/repository.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController
    with StateMixin<List<OrderModel>> {
  final OrdersRepository _repository;
  OrdersController(this._repository);

  @override
  void onInit() async {
    await getOrders();

    super.onInit();
  }

  Future getOrders() async {
    _repository.getOrders().then((data) {
      if (data.isEmpty) {
        change(data, status: RxStatus.empty());
      } else {
        change(data, status: RxStatus.success());
      }
    }, onError: (error) {
      change(null, status: RxStatus.error());
    });
  }
}
