import 'package:app_hortifruti/app/modules/dashboard/controller.dart';
import 'package:app_hortifruti/app/modules/home/page.dart';
import 'package:app_hortifruti/app/modules/orders/page.dart';
import 'package:app_hortifruti/app/modules/profile/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardPage extends GetView<DashBoardController> {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBar(
            onDestinationSelected:
                controller.currentPageIndex, //atualiza o inteiro
            selectedIndex: controller
                .currentPageIndex.value, //seleciona o inteiro atualizado
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.explore_outlined),
                  label: 'Início',
                  selectedIcon: Icon(Icons.explore)),
              NavigationDestination(
                  icon: Icon(Icons.person_outlined),
                  label: 'Meu Perfil',
                  selectedIcon: Icon(Icons.person)),
              NavigationDestination(
                  icon: Icon(Icons.view_list_outlined),
                  label: 'Meus Pedidos',
                  selectedIcon: Icon(Icons.view_list)),
            ],
          )),
      body: Obx(() => IndexedStack(
            index: controller.currentPageIndex.value,
            children: const [
              HomePage(),
              ProfilePage(),
              OrdersPage(),
            ],
          )),
    );
  }
}
