import 'package:app_hortifruti/app/modules/checkout/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends GetView<CheckoutController> {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Pedido')),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(padding: EdgeInsets.only(top: 20)),
              if (!controller.isLoggeed)
                OutlinedButton.icon(
                  onPressed: () => controller.goToLogin(),
                  icon: const Icon(Icons.login_outlined),
                  label: const Text('Entre com sua conta para continuar'),
                ),
              if (controller.isLoggeed && controller.adresses.isEmpty)
                ElevatedButton.icon(
                  onPressed: controller.goToNewAddress,
                  icon: const Icon(Icons.location_city),
                  label: const Text('Cadastrar Endereço'),
                )
              else
                ElevatedButton.icon(
                  onPressed: controller.showAddressList,
                  icon: const Icon(Icons.location_on),
                  label: const Text('Escolher/Cadastrar um Endereço'),
                ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Endereço:',
                      style: Get.textTheme.titleMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        controller.selectedAddress.value.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(indent: 20, thickness: 3, endIndent: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Forma de pagamento:',
                        style: Get.textTheme.titleMedium,
                      ),
                    ),
                    DropdownButton(
                      value: controller.selectedPayment.value,
                      items: [
                        for (var payment in controller.payment)
                          DropdownMenuItem(
                            value: payment,
                            child: Text(payment.name),
                          ),
                      ],
                      onChanged: (item) {
                        controller.changePayment(item!);
                      },
                    ),
                  ],
                ),
              ),
              const Divider(indent: 20, thickness: 3, endIndent: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Produtos:',
                        style: Get.textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      NumberFormat.simpleCurrency()
                          .format(controller.totalCart),
                      style: Get.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              const Divider(indent: 20, thickness: 3, endIndent: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Custo de entrega:',
                      style: Get.textTheme.titleMedium,
                    ),
                    Text(
                        NumberFormat.simpleCurrency()
                            .format(controller.deliveryCost),
                        style: Get.textTheme.titleMedium),
                  ],
                ),
              ),
              const Divider(indent: 20, thickness: 3, endIndent: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: Get.textTheme.titleMedium,
                    ),
                    Text(
                      NumberFormat.simpleCurrency()
                          .format(controller.totalOrder),
                      style: Get.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Enviar Pedido')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
