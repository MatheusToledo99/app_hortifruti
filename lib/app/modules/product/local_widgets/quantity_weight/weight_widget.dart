import 'package:app_hortifruti/app/modules/product/local_widgets/quantity_weight/quantity_weight_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Weight extends StatelessWidget {
  Weight({super.key});

  final controller = Get.find<QuantityAndWeightController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${(controller.minSlider * 1000).toStringAsFixed(0)}g'),
        Expanded(
          child: Slider(
            max: controller.maxSlider,
            min: controller.minSlider,
            value: controller.weight,
            onChanged: controller.changeWeight,
            divisions: controller.divisionsSlider,
            label: '${(controller.weight * 1000).toStringAsFixed(0)} g',
          ),
        ),
        Text('${(controller.maxSlider * 1000).toStringAsFixed(0)}g'),
      ],
    );
  }
}
