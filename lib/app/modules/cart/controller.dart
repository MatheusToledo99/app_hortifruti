import 'package:app_hortifruti/app/data/model/cart_product.dart';
import 'package:app_hortifruti/app/data/model/store.dart';
import 'package:app_hortifruti/app/data/services/cart/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends GetxController with StateMixin {
  final _cartService = Get.find<CartService>();
  List<CartProductModel> get products => _cartService.products;
  StoreModel? get store => _cartService.store.value;
  final cartObservationController = TextEditingController();

  void removerProduct(CartProductModel cartProduct) {
    _cartService.removeProductToCart(cartProduct);
  }

  @override
  onInit() {
    cartObservationController.text = _cartService.cartObservation.value;
    cartObservationController.addListener(() {
      _cartService.cartObservation.value = cartObservationController.text;
    });
    super.onInit();
  }
}
