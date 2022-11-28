import 'package:app_hortifruti/app/modules/orders/controller.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersPage extends GetView<OrdersController> {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.getOrders(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Meus Pedidos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
        ),
        body: controller.obx(
          (orders) => SingleChildScrollView(
            child: Column(
              children: [
                for (var order in orders!) ...[
                  ListTile(
                    shape: const Border(bottom: BorderSide(width: 1)),
                    isThreeLine: true,
                    leading: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        NumberFormat.simpleCurrency().format(order.value),
                      ),
                    ),
                    title: Text(
                      order.hashId,
                      style: const TextStyle(
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    subtitle: Text(
                      '${order.createAt.day}/${order.createAt.month}/${order.createAt.year}'
                      ' - ${order.store.name}',
                      style: const TextStyle(
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: order.statuses.last.name == 'Cancelado'
                            ? Colors.red
                            : Colors.green,
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        order.statuses.last.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(Routes.orderDetail, arguments: order.hashId);
                    },
                  ),
                ],
              ],
            ),
          ),
          onEmpty: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Não há pedidos cadastrados'),
                const Padding(padding: EdgeInsets.symmetric(vertical: 40)),
                OutlinedButton.icon(
                    onPressed: controller.goToBuySomething,
                    icon: const Icon(Icons.shopping_cart_outlined),
                    label: const Text('Como comprar?')),
              ],
            ),
          ),
          onError: (error) => Center(
            child: OutlinedButton.icon(
              onPressed: () => Get.toNamed(Routes.login),
              icon: const Icon(Icons.login_outlined),
              label: const Text('Entrar na minha conta'),
            ),
          ),
        ),
      ),
    );
  }
}
