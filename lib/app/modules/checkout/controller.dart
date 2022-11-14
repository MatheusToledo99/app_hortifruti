import 'package:app_hortifruti/app/core/utils/util_services.dart';
import 'package:app_hortifruti/app/data/model/address.dart';
import 'package:app_hortifruti/app/data/model/city_cost.dart';
import 'package:app_hortifruti/app/data/model/cart.dart';
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

  RxBool isLoading = true.obs;
  final _cartService = Get.find<CartService>();
  final _authService = Get.find<AuthService>();
  bool get isLoggeed => _authService.isLoggeed;
  double get totalCart => _cartService.total;
  final selectedPayment = Rxn<PaymentModel>();
  final adresses = RxList<AddressModel>();
  final selectedAddress = Rxn<AddressModel>();
  final moneyFor = TextEditingController();

  double get deliveryCost {
    if (getCityCostModel != null) return getCityCostModel!.cost;

    return 0.0;
  }

  double get totalOrder => totalCart + deliveryCost;

  List<PaymentModel> get payment => _cartService.store.value!.payment;

  CityCostModel? get getCityCostModel {
    var cityId = selectedAddress.value?.city?.id;
    return _cartService.store.value!.cityCosts.firstWhereOrNull(
      (element) => element.id == cityId,
    );
  }

  bool get deliveryToMyAddress {
    if (getCityCostModel != null) {
      return true;
    }
    selectedAddress.value = null;
    return false;
  }

  @override
  void onInit() {
    fetchUserAdress();

    super.onInit();
  }

  void changePayment(PaymentModel payment) {
    selectedPayment.value = payment;
  }

  void goToLogin() async {
    await Get.toNamed(Routes.login);
    fetchUserAdress();
  }

  void goToNewAddress() async {
    await Get.toNamed(Routes.address);
    fetchUserAdress();
  }

  void fetchUserAdress() {
    isLoading.value = true;
    _repository.getUserAddress().then((value) {
      adresses.assignAll(value);
      isLoading.value = false;
    }, onError: (error) {
      isLoading.value = false;
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

  void createOrder() {
    if (selectedPayment.value!.name == 'Dinheiro' &&
        double.parse(moneyFor.text) < totalOrder) {
      ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
        UtilServices().messageSnackBar(
            message: 'Troco deve ser maior que o valor do pedido',
            isError: true),
      );
      return;
    }
    if (selectedPayment.value == null) {
      ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
        UtilServices().messageSnackBar(
            message: 'Selecione um meio de pagamento', isError: true),
      );
      return;
    }

    if (selectedAddress.value == null) return;

    var order = CartModel(
      store: _cartService.store.value!,
      payment: selectedPayment.value!,
      cartProducts: _cartService.products,
      address: selectedAddress.value!,
      observation: _cartService.cartObservation.value,
      moneyFor: moneyFor.text.isEmpty ? null : double.parse(moneyFor.text),
    );

    _repository.postOrder(order).then(
          (value) => {
            moneyFor.text = '',
            UtilServices().showAlertDialog(
                message: 'Pedido Enviado',
                route: Routes.dashBoard,
                arguments: 2,
                barrierDismissible: false,
                routeMessage: 'Ver Meus Pedidos'),
            _cartService.clearCart()
          },
        );
  }
}
