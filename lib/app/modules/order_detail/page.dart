import 'package:app_hortifruti/app/modules/order_detail/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetailPage extends GetView<OrderDetailController> {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Detalhamento do Pedido'), centerTitle: true),
      body: controller.obx(
        (state) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Obx(
              () => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 2, child: Text('Pedido')),
                      Expanded(
                        flex: 1,
                        child: Text(
                          state!.hashId,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 2, child: Text('Estabelecimento')),
                      Expanded(
                        flex: 1,
                        child: Text(
                          state.store.name,
                          style: const TextStyle(
                            overflow: TextOverflow.fade,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 2, child: Text('Meio de Pagamento')),
                      Expanded(
                        flex: 1,
                        child: Text(
                          state.payment!.name,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                          flex: 2, child: Text('Status atual do pedido')),
                      Expanded(
                        flex: 1,
                        child: Text(
                          state.statuses.last.name,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 2, child: Text('Data do Pedido')),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${state.createAt.day}/${state.createAt.month}/${state.createAt.year}',
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 2, child: Text('Subtotal')),
                      Expanded(
                        flex: 1,
                        child: Text(
                          NumberFormat.simpleCurrency()
                              .format((state.value - state.deliveryCoast)),
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 2, child: Text('Taxa de Entrega')),
                      Expanded(
                        flex: 1,
                        child: Text(
                          state.deliveryCoast == 0.0
                              ? 'Grátis'
                              : NumberFormat.simpleCurrency()
                                  .format(state.deliveryCoast),
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 2, child: Text('Total')),
                      Expanded(
                        flex: 1,
                        child: Text(
                          NumberFormat.simpleCurrency().format(state.value),
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListTile(
                      onTap: controller.changeVisible,
                      title: const Text(" Produtos"),
                      trailing: controller.visible.value
                          ? const Icon(Icons.keyboard_arrow_down_outlined)
                          : const Icon(Icons.keyboard_arrow_left_outlined),
                    ),
                  ),
                  for (var orderDetail in state.orderDetail!)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Visibility(
                        visible: controller.visible.value,
                        child: ListTile(
                          isThreeLine: true,
                          title: Text(orderDetail.product.name),
                          subtitle: Text(
                            orderDetail.product.isKG
                                ? '${NumberFormat.simpleCurrency().format(orderDetail.product.price)}/${orderDetail.product.unit.toLowerCase()}'
                                : NumberFormat.simpleCurrency()
                                    .format(orderDetail.product.price),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: orderDetail.product.image != null
                                ? Image.network(orderDetail.product.image!)
                                : Image.asset('assets/images/semFoto.png'),
                          ),
                          trailing: Text('${orderDetail.quantity}x'),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
