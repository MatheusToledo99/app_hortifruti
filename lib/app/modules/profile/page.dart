import 'package:app_hortifruti/app/modules/profile/controller.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meu Perfil',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              if (controller.isLoggeed) ...[
                const PopupMenuItem(
                  value: 'logout',
                  child: Text('Logout'),
                ),
                const PopupMenuItem(
                  value: 'addresses',
                  child: Text('Meus Endereços'),
                ),
              ],
            ],
            onSelected: (value) {
              if (value == 'logout') {
                controller.logout();
              } else if (value == 'addresses') {
                Get.toNamed(Routes.profileAddresses);
              } else {
                return;
              }
            },
          ),
        ],
      ),
      body: controller.obx(
        (state) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(labelText: 'Nome:'),
                    controller: controller.nameController,
                    validator: (String? nome) {
                      if (nome != null && nome.isEmpty) {
                        return 'Favor digite seu nome';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.none,
                    decoration: const InputDecoration(labelText: 'Email:'),
                    controller: controller.emailController,
                    validator: (String? email) {
                      if (email != null && !EmailValidator.validate(email)) {
                        return 'Favor digite seu email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Telefone:'),
                    controller: controller.phoneController,
                    validator: (String? telefone) {
                      if (telefone != null && telefone.isEmpty) {
                        return 'Favor digite seu telefone válido';
                      }
                      return null;
                    },
                    inputFormatters: [controller.mask],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha:',
                      hintText: 'Digite a senha se deseja atualizá-la',
                    ),
                    controller: controller.passwordController,
                    validator: (String? password) {
                      if (password != null &&
                          password.isNotEmpty &&
                          password.length < 3) {
                        return 'Favor digite uma senha válida';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: OutlinedButton.icon(
                    onPressed: controller.submit,
                    icon: const Icon(Icons.update_outlined),
                    label: const Text('Atualizar'),
                  ),
                ),
              ],
            ),
          ),
        ),
        onError: (error) => Center(
          child: OutlinedButton.icon(
            onPressed: () => Get.toNamed(Routes.login),
            icon: const Icon(Icons.login_outlined),
            label: const Text('Entrar na minha conta'),
          ),
        ),
      ),
    );
  }
}
