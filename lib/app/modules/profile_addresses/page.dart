import 'package:app_hortifruti/app/modules/profile_addresses/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAddressesPage extends GetView<ProfileAddressesController> {
  const ProfileAddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: controller.obx(
        (state) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: [
                Center(
                  child: OutlinedButton.icon(
                    onPressed: controller.goToNewAddress,
                    icon: const Icon(Icons.location_city),
                    label: const Text('Cadastrar Endereço'),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                if (state!.isEmpty)
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.30),
                    child:
                        const Text('Não há endereços cadastradas ao seu login'),
                  ),
                for (var address in state)
                  ListTile(
                    isThreeLine: true,
                    title:
                        Text('${address.street}, ${address.number ?? 's/nº'}'),
                    subtitle: Text(
                        '${address.district}, ${address.complement ?? ''}'),
                    trailing: PopupMenuButton(
                      // onCanceled: () => Get.back(),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Editar'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Deletar'),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 'edit') {
                          controller.goToEditAddress(address);
                        } else if (value == 'delete') {
                          controller.deleteUserAddress(address);
                        } else {
                          return;
                        }
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
