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
      onRefresh: () async => controller.atualizar(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => Get.offAllNamed(Routes.cities),
              icon: const Icon(Icons.location_on_outlined),
              padding: const EdgeInsets.only(right: 30),
            ),
          ],
          title: Text(
            'Hortifruti - ${controller.city.name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: controller.obx(
          (state) => Column(
            children: [
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: TextFormField(
                  onChanged: (value) {
                    controller.searchTitle.text = value;
                    controller.onChanged();
                  },
                  decoration: InputDecoration(
                    hintText: 'Pesquise um estabelecimento...',
                    suffixIcon: const Icon(Icons.search_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60)),
                  ),
                ),
              ),
              if (state!.isNotEmpty) ...[
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: false,
                    physics: const AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (context, _) => const Divider(),
                    itemCount: state.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        onTap: () {
                          controller.downkeyboard();
                          Get.toNamed(
                            Routes.store.replaceFirst(
                              ':id',
                              state[index].id.toString(),
                            ),
                          );
                        },
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
                ),
              ] else ...[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.27),
                  child: const Center(
                    child: Text(
                        'Não há estabelecimentos contidos na sua pesquisa'),
                  ),
                )
              ],
            ],
          ),
          onError: (error) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ocorreu um erro ao buscar os estabelecimentos desta cidade, tente novamente.',
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
              OutlinedButton(
                onPressed: controller.onInit,
                child: const Text('Tentar Novamente'),
              ),
            ],
          ),
          onEmpty: const Center(
              child: Text('Não há estabelecimentos cadastrados nesta cidade')),
        ),
      ),
    );
  }
}
