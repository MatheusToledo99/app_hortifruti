import 'package:app_hortifruti/app/core/utils/util_services.dart';
import 'package:app_hortifruti/app/data/model/city.dart';
import 'package:app_hortifruti/app/data/services/city/service.dart';
import 'package:app_hortifruti/app/modules/cities/repository.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:get/get.dart';

class CitiesController extends GetxController with StateMixin<List<CityModel>> {
  final CitiesRepository _repository;
  final _selectedCity = Get.find<CitiesService>();
  final utilServices = UtilServices();

  CitiesController(this._repository);

  @override
  void onInit() {
    _repository.getCities().then((data) {
      change(data, status: RxStatus.success());
    }, onError: (err) {
      print(err);
      change(
        null,
        status: RxStatus.error('Error get data'),
      );
      super.onInit();
    });
  }

  void goToHomeWithCity(CityModel city) {
    _selectedCity.selectedCity.value = city;
    Get.toNamed(Routes.dashBoard);
  }

  void goToHomeWithoutCity() {
    if (_selectedCity.selectedCity.value != null) {
      Get.toNamed(Routes.dashBoard);
      return;
    }
    utilServices.messageSnackBar(
      message: 'Selecione uma cidade para iniciar',
      isError: true,
      duration: 2,
    );
  }
}
