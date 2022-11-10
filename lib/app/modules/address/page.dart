import 'package:app_hortifruti/app/modules/address/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressPage extends GetView<AddressController> {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(controller.isEditing.value
            ? 'Alteração de Endereço'
            : 'Cadastro de Endereço'),
      ),
      body: controller.obx(
        (state) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Rua:'),
                    controller: controller.streetController,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return '* O Campo "Rua" é obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Número:'),
                    controller: controller.numberController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Bairro:'),
                    controller: controller.districtController,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return '* O Campo "Bairro" é obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Complemento:'),
                    controller: controller.complementController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Ponto de referência:'),
                    controller: controller.referencePointController,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Cidade:',
                          style: Get.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    Obx(
                      () => Expanded(
                        flex: 5,
                        child: DropdownButtonFormField(
                          hint: controller.selectedCity.value == null
                              ? const Text('Selecione uma cidade')
                              : null,
                          validator: (value) {
                            if (value == null) {
                              return '* O campo "Cidade" é obrigatório';
                            }
                            return null;
                          },
                          value: controller.selectedCity.value,
                          items: [
                            for (var city in state!)
                              DropdownMenuItem(
                                value: city,
                                child: Text(city.name),
                              ),
                          ],
                          onChanged: (item) {
                            controller.changeCity(item!);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton.icon(
                    onPressed: controller.submit,
                    icon: Icon(controller.isEditing.value
                        ? Icons.update_outlined
                        : Icons.home_work_outlined),
                    label: Text(
                        controller.isEditing.value ? 'Atualizar' : 'Adicionar'),
                  ),
                ),
              ],
            ),
          ),
        ),
        onError: (error) => Text(error!),
        onEmpty: const Text('Não há cidades cadastradas no sistema'),
      ),
    );
  }
}
