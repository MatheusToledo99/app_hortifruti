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
      onRefresh: controller.getOrders,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Meus Pedidos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            automaticallyImplyLeading: false),
        body: controller.obx(
          (orders) => SingleChildScrollView(
            child: Column(
              children: [
                for (var order in orders!)
                  ListTile(
                    shape: const Border(
                      bottom: BorderSide(width: 1),
                    ),
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: order.statuses.last.name == 'Cancelado'
                            ? Colors.red
                            : Colors.green[300],
                      ),
                      child: Text(
                        order.statuses.last.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(Routes.orderDetail, arguments: order.hashId);
                    },
                  ),
              ],
            ),
          ),
          onEmpty: const Center(child: Text('Não há pedidos cadastrados')),
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
