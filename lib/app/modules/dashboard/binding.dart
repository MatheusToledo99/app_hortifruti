import 'package:app_hortifruti/app/data/provider/api.dart';
import 'package:app_hortifruti/app/modules/dashboard/controller.dart';
import 'package:app_hortifruti/app/modules/home/controller.dart';
import 'package:app_hortifruti/app/modules/home/repository.dart';
import 'package:app_hortifruti/app/modules/orders/controller.dart';
import 'package:app_hortifruti/app/modules/orders/repository.dart';
import 'package:app_hortifruti/app/modules/profile/controller.dart';
import 'package:app_hortifruti/app/modules/profile/repository.dart';
import 'package:get/get.dart';

class DashBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController());
    Get.lazyPut<HomeController>(
        () => HomeController(HomeRepository(Get.find<Api>())));
    Get.lazyPut<ProfileController>(
        () => ProfileController(ProfileRepository(Get.find<Api>())));
    Get.lazyPut<OrdersController>(
        () => OrdersController(OrdersRepository(Get.find<Api>())));
  }
}
