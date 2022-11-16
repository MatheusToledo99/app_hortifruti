import 'package:app_hortifruti/app/data/model/order.dart';
import 'package:app_hortifruti/app/modules/order_detail/repository.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController with StateMixin<OrderModel> {
  final OrderDetailRepository _repository;
  OrderDetailController(this._repository);

  RxBool visible = true.obs;

  bool changeVisible() {
    visible.value = !visible.value;
    return visible.value;
  }

  @override
  void onInit() {
    String hashId = Get.arguments;

    _repository.getOrder(hashId).then(
      (data) => change(data, status: RxStatus.success()),
      onError: (error) {
        change(null, status: RxStatus.error(error!));
      },
    );

    super.onInit();
  }
}
