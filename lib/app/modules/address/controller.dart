import 'package:app_hortifruti/app/data/model/address.dart';
import 'package:app_hortifruti/app/data/model/city.dart';
import 'package:app_hortifruti/app/core/utils/util_services.dart';
import 'package:app_hortifruti/app/modules/address/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController
    with StateMixin<List<CityModel>> {
//
//
//
  final AddressRepository _repository;
  AddressController(this._repository);

  final selectedCity = Rxn<CityModel>();
  final formKey = GlobalKey<FormState>();

  TextEditingController streetController = TextEditingController(text: 'Rua C');
  TextEditingController numberController = TextEditingController(text: '123');
  TextEditingController districtController =
      TextEditingController(text: 'Santana');
  TextEditingController referencePointController = TextEditingController();
  TextEditingController complementController = TextEditingController();

  @override
  void onInit() {
    _repository.getCities().then(
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

    super.onInit();
  }

  changeCity(CityModel city) {
    selectedCity.value = city;
  }

  void submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    var address = AddressModel(
      city: selectedCity.value,
      street: streetController.text,
      number: numberController.text.isEmpty ? null : numberController.text,
      district: districtController.text,
      referencePoint: referencePointController.text.isEmpty
          ? null
          : referencePointController.text,
      complement:
          complementController.text.isEmpty ? null : complementController.text,
    );

    _repository.postUserAddress(address).then(
      (value) {
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
          UtilServices()
              .messageSnackBar(message: 'Endereço criado com sucesso'),
        );
      },
      onError: (error) {
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
          UtilServices().messageSnackBar(
              message: 'Ocorreu um erro, tente novamente mais tarde',
              isError: true),
        );
      },
    );

    Future.delayed(
      const Duration(milliseconds: 300),
      () => Get.back(),
    );
  }
}
