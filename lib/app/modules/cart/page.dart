import 'package:app_hortifruti/app/modules/cart/controller.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: controller.products.isNotEmpty
                      ? TextField(
                          maxLength: 100,
                          decoration:
                              const InputDecoration(labelText: 'Observação'),
                          controller: controller.cartObservationController,
                        )
                      : null,
                ),
                if (controller.store != null) Text(controller.store!.name),
                for (var cartProduct in controller.products)
                  ListTile(
                    leading: cartProduct.product.isKG
                        ? Text(
                            "${NumberFormat.decimalPattern().format(cartProduct.quantity)}/kg")
                        : Text("${cartProduct.quantity.toStringAsFixed(0)} x "),
                    title: cartProduct.product.isKG || cartProduct.quantity < 1
                        ? Text(cartProduct.product.name)
                        : Text("${cartProduct.product.name}s "),
                    subtitle: Text(
                      '${NumberFormat.simpleCurrency().format(cartProduct.total)} '
                      '(${NumberFormat.simpleCurrency().format(cartProduct.product.price)})',
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        controller.removerProduct(cartProduct);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                if (controller.products.isEmpty) ...[
                  Center(
                    heightFactor: 13,
                    child: Column(
                      children: const [
                        Text('Seu carrinho está vazio'),
                        Icon(Icons.remove_shopping_cart_outlined),
                      ],
                    ),
                  )
                ] else
                  OutlinedButton(
                    onPressed: () => Get.toNamed(Routes.checkout),
                    child: const Text('Avançar'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
