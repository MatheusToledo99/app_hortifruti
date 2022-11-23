import 'package:app_hortifruti/app/data/model/city.dart';
import 'package:app_hortifruti/app/data/model/store.dart';
import 'package:app_hortifruti/app/data/services/city/service.dart';
import 'package:get/get.dart';

import 'package:app_hortifruti/app/modules/home/repository.dart';

class HomeController extends GetxController with StateMixin<List<StoreModel>> {
  final HomeRepository _repository;
  final _selectedCity = Get.find<CitiesService>();
  CityModel get city => _selectedCity.selectedCity.value!;

  HomeController(this._repository);

  @override
  void onInit() async {
    atualizar();

    super.onInit();
  }

  void atualizar() {
    _repository.getStores(_selectedCity.selectedCity.value!.id).then(
      (data) {
        if (data.isEmpty) {
          change([], status: RxStatus.empty());
        } else {
          change(data, status: RxStatus.success());
        }
      },
      onError: (error) {
        change(null, status: RxStatus.error(error));
      },
    );
  }
}
