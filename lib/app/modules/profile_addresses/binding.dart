import 'package:app_hortifruti/app/data/provider/api.dart';
import 'package:app_hortifruti/app/modules/profile_addresses/controller.dart';
import 'package:app_hortifruti/app/modules/profile_addresses/repository.dart';
import 'package:get/get.dart';

class ProfileAddressesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileAddressesController>(() => ProfileAddressesController(
        ProfileAddressesRepository(Get.find<Api>())));
  }
}
