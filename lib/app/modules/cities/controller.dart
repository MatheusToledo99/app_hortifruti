import 'package:app_hortifruti/app/data/model/city.dart';
import 'package:app_hortifruti/app/data/services/city/service.dart';
import 'package:app_hortifruti/app/modules/cities/repository.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:get/get.dart';

class CitiesController extends GetxController with StateMixin<List<CityModel>> {
  final CitiesRepository _repository;
  final _selectedCity = Get.find<CitiesService>();

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

  void goToHome(CityModel city) {
    _selectedCity.selectedCity.value = city;
    Get.toNamed(Routes.dashBoard);
  }
}
