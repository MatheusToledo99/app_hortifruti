import 'package:app_hortifruti/app/data/provider/api.dart';
import 'package:app_hortifruti/app/modules/order_detail/controller.dart';
import 'package:app_hortifruti/app/modules/order_detail/repository.dart';
import 'package:get/get.dart';

class OrderDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailController>(
        () => OrderDetailController(OrderDetailRepository(Get.find<Api>())));
  }
}
