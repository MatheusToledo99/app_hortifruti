import 'package:app_hortifruti/app/data/provider/api.dart';
import 'package:app_hortifruti/app/modules/registration/controller.dart';
import 'package:app_hortifruti/app/modules/registration/repository.dart';
import 'package:get/get.dart';

class RegistrationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(
        () => RegistrationController(RegistrationRepository(Get.find<Api>())));
  }
}
