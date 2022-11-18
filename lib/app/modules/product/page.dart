import 'package:app_hortifruti/app/modules/product/controller.dart';
import 'package:app_hortifruti/app/modules/product/local_widgets/quantity_weight/quantity_weight_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.product.value!.name,
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        reverse: true,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: controller.product.value?.image != null
                      ? Image.network(controller.product.value!.image!)
                      : Image.asset('assets/images/semFoto.png'),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            controller.product.value?.description != null
                                ? Text(
                                    controller.product.value!.description!,
                                    style: Get.textTheme.titleLarge,
                                    textAlign: TextAlign.start,
                                  )
                                : const Text(
                                    'Este produto não contém uma descrição'),
                            Text(
                                "${NumberFormat.simpleCurrency().format(controller.product.value!.price)}/${controller.product.value!.unit.toLowerCase()}",
                                style: Get.textTheme.titleMedium),
                          ],
                        ),
                        TextField(
                          maxLength: 100,
                          decoration:
                              const InputDecoration(labelText: 'Observação'),
                          controller: controller.productObservationController,
                        ),
                        QuantityAndWeight(isKg: controller.product.value!.isKG),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.height * 0.3,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              controller.addToCart();
                            },
                            child: const Text(
                              'Adicionar ao Carrinho',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
