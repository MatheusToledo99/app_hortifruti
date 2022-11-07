import 'package:get/get.dart';

class QuantityAndWeightController extends GetxController {
  bool isKg;
  int quantity = 0;
  double weight = 0.0;
  double totalQuantity = 0.0;
  double minSlider = 0.0;
  double maxSlider = 0.9;
  int divisionsSlider = 9;

  QuantityAndWeightController({required this.isKg});

  @override
  void onInit() {
    if (!isKg) {
      totalQuantity = 1.0;
      quantity = 1;
    } else {
      totalQuantity = 0.1;
      weight = 0.1;
      minSlider = 0.1;
      divisionsSlider = 8;
    }
    super.onInit();
  }

  void changeQuantity(int value) {
    quantity = value + quantity;

    if (!isKg && quantity <= 1) {
      quantity = 1;
    } else if (isKg && quantity <= 0 && weight <= 0) {
      quantity = 0;
      weight = 0.1;
      minSlider = 0.1;
      divisionsSlider = 8;
    } else if (isKg && quantity <= 0 && weight >= 0.1) {
      quantity = 0;
      minSlider = 0.1;
      divisionsSlider = 8;
    } else if (isKg) {
      minSlider = 0.0;
      divisionsSlider = 9;
    }

    if (quantity < 0) {
      weight = 0.1;
      quantity = 0;
      minSlider = 0.1;
      divisionsSlider = 8;
    }

    totalQuantity = quantity + weight;

    update();
  }

  void changeWeight(double value) {
    weight = value;

    totalQuantity = quantity + weight;

    update();
  }
}
