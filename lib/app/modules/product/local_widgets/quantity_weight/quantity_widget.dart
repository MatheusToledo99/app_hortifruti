import 'package:app_hortifruti/app/modules/product/local_widgets/quantity_weight/quantity_weight_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Quantity extends StatelessWidget {
  Quantity({super.key});

  final controller = Get.find<QuantityAndWeightController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
          onPressed: () => controller.changeQuantity(-1),
          onLongPress: () => controller.changeQuantity(-controller.quantity),
          child: const Icon(Icons.remove),
        ),
        Text(
          NumberFormat.decimalPattern().format(controller.totalQuantity) +
              (controller.isKg ? 'kg' : ''),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        OutlinedButton(
          onPressed: () => controller.changeQuantity(1),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
