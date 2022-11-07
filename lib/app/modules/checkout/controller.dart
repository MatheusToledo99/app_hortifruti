// ignore_for_file: unused_field

import 'package:app_hortifruti/app/data/model/address.dart';
import 'package:app_hortifruti/app/data/model/city_cost.dart';
import 'package:app_hortifruti/app/data/model/payment.dart';
import 'package:app_hortifruti/app/data/services/auth/service.dart';
import 'package:app_hortifruti/app/data/services/cart/service.dart';
import 'package:app_hortifruti/app/modules/checkout/repository.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final CheckoutRepository _repository;
  CheckoutController(this._repository);

  final _cartService = Get.find<CartService>();
  final _authService = Get.find<AuthService>();
  double get totalCart => _cartService.total;
  bool get isLoggeed => _authService.isLoggeed;
  final selectedPayment = Rxn<PaymentModel>();
  final adresses = RxList<AddressModel>();
  final selectedAddress = Rxn<AddressModel>();

  double get deliveryCost {
    if (getCityCostModel != null) {
      return getCityCostModel!.cost;
    }
    return 0.0;
  }

  double get totalOrder => totalCart + deliveryCost;
  List<PaymentModel> get payment => _cartService.store.value!.payment;
  CityCostModel? get getCityCostModel {
    var cityId = 1;
    return _cartService.store.value!.cityCosts.firstWhereOrNull(
      (element) => element.id == cityId,
    );
  }

  @override
  void onInit() {
    fetchUserAdress();

    super.onInit();
  }

  void changePayment(PaymentModel payment) {
    selectedPayment.value = payment;
  }

  void goToLogin() {
    Get.toNamed(Routes.login);
  }

  void goToNewAddress() {
    Get.toNamed(Routes.address);
  }

  fetchUserAdress() {
    _repository.getUserAddress().then((value) {
      adresses.addAll(value);
    });
  }

  void showAddressList() {
    Get.dialog(
      SimpleDialog(
        children: [
          for (var address in adresses)
            SimpleDialogOption(
              onPressed: () {
                selectedAddress.value = address;
                print(selectedAddress.value);
                Get.back();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(address.toString()),
                  ),
                  const Divider(indent: 20, thickness: 3, endIndent: 20),
                ],
              ),
            ),
          TextButton(
            onPressed: () {
              Get.back();
              goToNewAddress();
            },
            child: const Text('Cadastrar novo endereço'),
          ),
        ],
      ),
    );
  }
}
