import 'package:app_hortifruti/app/core/utils/util_services.dart';
import 'package:app_hortifruti/app/data/model/city.dart';
import 'package:app_hortifruti/app/data/services/city/service.dart';
import 'package:app_hortifruti/app/modules/cities/repository.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CitiesController extends GetxController with StateMixin<List<CityModel>> {
  final CitiesRepository _repository;
  final _selectedCity = Get.find<CitiesService>();
  final utilServices = UtilServices();
  var searchCity = TextEditingController();
  List<CityModel>? listCities;
  CitiesController(this._repository);

  @override
  void onInit() {
    _repository.getCities().then((data) {
      change(data, status: RxStatus.success());
      listCities = data;
    }, onError: (error) {
      change(null, status: RxStatus.error(error));
      super.onInit();
    });
  }

  void goToHomeWithCity(CityModel city) {
    _selectedCity.selectedCity.value = city;
    Get.toNamed(Routes.dashBoard);

    downkeyboard();
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

    downkeyboard();
  }

  void onChanged() {
    List<CityModel>? data = listCities
        ?.where(
          (element) => element
              .toString()
              .toLowerCase()
              .contains(searchCity.text.toLowerCase()),
        )
        .toList();

    if (data!.isEmpty) {
      change([], status: RxStatus.empty());
    }

    change(data, status: RxStatus.success());

    downkeyboard();
  }

  void downkeyboard() {
    if (searchCity.text.isEmpty) {
      Get.focusScope!.unfocus();
    }
    return;
  }
}
