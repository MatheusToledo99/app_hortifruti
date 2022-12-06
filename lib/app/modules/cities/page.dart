import 'package:app_hortifruti/app/modules/cities/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CitiesPage extends GetView<CitiesController> {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/backgroundCity.jpg',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              onPressed: controller.goToHomeWithoutCity,
              icon: const Icon(Icons.close),
            ),
            backgroundColor: Colors.transparent,
            title: const Text(
              'Cidades Atendidas',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: controller.obx(
            (cities) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      controller.searchCity.text = value;
                      controller.onChanged();
                    },
                    decoration: InputDecoration(
                      hintText: 'Qual cidade que você deseja?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var city in cities!) ...[
                          ListTile(
                            title: Text(
                              textAlign: TextAlign.center,
                              city.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              city.uf,
                              textAlign: TextAlign.center,
                            ),
                            onTap: () => controller.goToHomeWithCity(city),
                          ),
                          const Divider(thickness: 1, color: Colors.black38),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
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
          ),
        ),
      ],
    );
  }
}
