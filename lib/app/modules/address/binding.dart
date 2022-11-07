import 'package:app_hortifruti/app/data/provider/api.dart';
import 'package:app_hortifruti/app/modules/address/controller.dart';
import 'package:app_hortifruti/app/modules/address/repository.dart';
import 'package:get/get.dart';

class AddressBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(
        () => AddressController(AddressRepository(Get.find<Api>())));
  }
}
