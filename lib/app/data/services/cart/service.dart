import 'package:app_hortifruti/app/data/model/cart_product.dart';
import 'package:app_hortifruti/app/data/model/store.dart';
import 'package:get/get.dart';

class CartService extends GetxService {
  final List<CartProductModel> products = RxList<CartProductModel>.empty();
  final cartObservation = ''.obs;
  final store = Rxn<StoreModel>();
  double get total => totalCart();

  void addProductToCart(CartProductModel cartProduct) {
    products.add(cartProduct);
  }

  void newCart(StoreModel newStore) {
    store.value = newStore;
    products.clear();
    cartObservation.value = '';
  }

  bool isNewStore(StoreModel currentStore) {
    if (store.value == null) {
      return false;
    }

    return store.value!.id != currentStore.id;
  }

  void clearCart() {
    products.clear();
    cartObservation.value = '';
  }

  void removeProductToCart(CartProductModel cartProduct) {
    products.remove(cartProduct);
    if (products.isEmpty) {
      store.value = null;
      cartObservation.value = '';
    }
  }

  double totalCart() {
    double total = 0;
    for (var cartProduct in products) {
      total = total + cartProduct.total;
    }
    return total;
  }
}
