import 'package:app_hortifruti/app/data/model/cart_product.dart';
import 'package:app_hortifruti/app/data/model/product.dart';
import 'package:app_hortifruti/app/data/model/store.dart';
import 'package:app_hortifruti/app/data/services/cart/service.dart';
import 'package:app_hortifruti/app/core/utils/util_services.dart';
import 'package:app_hortifruti/app/modules/product/local_widgets/quantity_weight/quantity_weight_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController with StateMixin<ProductModel> {
  final product = Rxn<ProductModel>();
  final store = Rxn<StoreModel>();
  final productObservationController = TextEditingController();
  final _cartService = Get.find<CartService>();

  @override
  void onInit() {
    product.value = Get.arguments['product'];
    store.value = Get.arguments['store'];

    super.onInit();
  }

  void addToCart() async {
    final totalQuantity = Get.find<QuantityAndWeightController>().totalQuantity;

    if (_cartService.isNewStore(store.value!)) {
      if (await UtilServices().showDialogNewCart(
          message: 'Seu carrinho do estabelecimento será excluído')) {
        _cartService.clearCart();
      } else {
        return;
      }
    }

    if (_cartService.products.isEmpty) {
      _cartService.newCart(store.value!);
    }

    _cartService.addProductToCart(
      CartProductModel(
        product: product.value!,
        quantity: totalQuantity,
        observation: productObservationController.text,
      ),
    );

    ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(UtilServices()
        .messageSnackBar(
            message:
                'O item ${product.value!.name} foi adicionado com sucesso'));

    Future.delayed(
      const Duration(milliseconds: 300),
      () => Get.back(),
    );
  }
}
