import 'package:app_hortifruti/app/global_widgets/store_status.dart';
import 'package:app_hortifruti/app/modules/store/controller.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StorePage extends GetView<StoreController> {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.cart);
        },
        tooltip: 'Ver carrinho',
        child: const Icon(Icons.shopping_cart_outlined),
      ),
      body: controller.obx(
        (state) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: state?.image != null
                          ? Image.network(state!.image!)
                          : const Icon(Icons.add_business_outlined),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state!.name,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        StoreStatus(store: state),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.greenAccent[50],
                  border: Border.all(width: 2, color: Colors.black),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView.separated(
                  separatorBuilder: (context, _) => const Divider(),
                  scrollDirection: Axis.vertical,
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: Text(state.categories[index].name),
                      children: [
                        for (var product in state.categories[index].products)
                          ListTile(
                            title: Text(product.name),
                            subtitle: Text(
                              product.isKG
                                  ? '${NumberFormat.simpleCurrency().format(product.price)}/${product.unit.toLowerCase()}'
                                  : NumberFormat.simpleCurrency()
                                      .format(product.price),
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: product.image != null
                                  ? Image.network(product.image!)
                                  : Image.asset('assets/images/semFoto.png'),
                            ),
                            onTap: () {
                              Get.toNamed(
                                Routes.product,
                                arguments: {'product': product, 'store': state},
                              );
                            },
                          ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
        onError: (error) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ocorreu um erro ao buscar os produtos deste estabelecimento, tente novamente.',
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
            OutlinedButton(
              onPressed: controller.onInit,
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
