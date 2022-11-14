import 'package:app_hortifruti/app/global_widgets/store_status.dart';
import 'package:app_hortifruti/app/modules/home/controller.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.atualizar(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hortifruti'),
          centerTitle: true,
        ),
        body: controller.obx(
          (state) => ListView.separated(
            shrinkWrap: false,
            physics: const AlwaysScrollableScrollPhysics(),
            separatorBuilder: (context, _) => const Divider(),
            itemCount: state!.length,
            itemBuilder: ((context, index) {
              return ListTile(
                onTap: () => Get.toNamed(Routes.store
                    .replaceFirst(':id', state[index].id.toString())),
                title: Text(state[index].name),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: state[index].image != null
                        ? Image.network(state[index].image!)
                        : const Icon(Icons.add_business_outlined),
                  ),
                ),
                trailing: StoreStatus(
                  store: state[index],
                ),
              );
            }),
          ),
          onError: (error) => Center(
            child: Text(error!),
          ),
          onEmpty: const Center(
              child: Text('Não há estabelecimentos cadastrados nesta cidade')),
        ),
      ),
    );
  }
}
