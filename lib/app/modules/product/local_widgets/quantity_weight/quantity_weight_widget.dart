import 'package:app_hortifruti/app/modules/product/local_widgets/quantity_weight/quantity_weight_controller.dart';
import 'package:app_hortifruti/app/modules/product/local_widgets/quantity_weight/weight_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'quantity_widget.dart';

class QuantityAndWeight extends StatelessWidget {
  final bool isKg;
  const QuantityAndWeight({
    Key? key,
    this.isKg = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuantityAndWeightController>(
      init: QuantityAndWeightController(isKg: isKg),
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              isKg
                  ? const Text('Altere o Peso:')
                  : const Text('Altere a Quantidade:'),
              Quantity(),
              if (isKg) Weight(),
            ],
          ),
        );
      },
    );
  }
}
