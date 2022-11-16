import 'package:app_hortifruti/app/modules/cities/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CitiesPage extends GetView<CitiesController> {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cidades Atendidas'),
        centerTitle: true,
      ),
      body: controller.obx(
          (cities) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Divider(thickness: 1, color: Colors.black38),
                      for (var city in cities!) ...[
                        ListTile(
                          title: Text(city.name),
                          subtitle: Text(city.uf),
                          onTap: () => controller.goToHome(city),
                        ),
                        const Divider(thickness: 1, color: Colors.black38),
                      ],
                    ],
                  ),
                ),
              ),
          onError: (error) => const Text(
              'Não foi possível recuperar as cidades, tente novamente mais tarde')),
    );
  }
}
