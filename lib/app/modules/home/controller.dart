import 'package:app_hortifruti/app/data/model/city.dart';
import 'package:app_hortifruti/app/data/model/store.dart';
import 'package:app_hortifruti/app/data/services/city/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:app_hortifruti/app/modules/home/repository.dart';

class HomeController extends GetxController with StateMixin<List<StoreModel>> {
  final HomeRepository _repository;
  final _cityService = Get.find<CitiesService>();
  CityModel get city => _cityService.selectedCity.value!;
  List<StoreModel>? listStore;
  var searchTitle = TextEditingController();

  HomeController(this._repository);

  @override
  void onInit() async {
    atualizar();

    super.onInit();
  }

  void atualizar() {
    downkeyboard();

    _repository.getStores(_cityService.selectedCity.value!.id).then(
      (data) {
        if (data.isEmpty) {
          change([], status: RxStatus.empty());
        } else {
          change(data, status: RxStatus.success());
          listStore = data;
        }
      },
      onError: (error) {
        change(null, status: RxStatus.error(error));
      },
    );
  }

  void onChanged() {
    List<StoreModel>? data = listStore
        ?.where(
          (element) => element.name
              .toLowerCase()
              .contains(searchTitle.text.toLowerCase()),
        )
        .toList();

    if (data!.isEmpty) {
      change([], status: RxStatus.empty());
    }

    change(data, status: RxStatus.success());

    downkeyboard();
  }

  void downkeyboard() {
    if (searchTitle.text.isEmpty) {
      Get.focusScope!.unfocus();
    }
    return;
  }
}
