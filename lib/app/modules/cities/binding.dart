import 'package:app_hortifruti/app/data/provider/api.dart';
import 'package:app_hortifruti/app/modules/cities/controller.dart';
import 'package:app_hortifruti/app/modules/cities/repository.dart';
import 'package:get/get.dart';

class CitiesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CitiesController>(
        () => CitiesController(CitiesRepository(Get.find<Api>())));
  }
}
