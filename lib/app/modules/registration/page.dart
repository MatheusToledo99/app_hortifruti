import 'package:app_hortifruti/app/modules/registration/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';

class RegistrationPage extends GetView<RegistrationController> {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastramento'), centerTitle: true),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text('Nome')),
                    controller: controller.nameController,
                    validator: (nome) {
                      if (nome != null && nome.isEmpty) {
                        return 'Digite seu nome';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text('Email')),
                    controller: controller.emailController,
                    validator: (email) {
                      if (email != null && !EmailValidator.validate(email)) {
                        return 'Digite um email válido';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text('Telefone')),
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text('Senha')),
                    controller: controller.passwordController,
                    validator: (password) {
                      if (password != null && password.isEmpty) {
                        return 'Digite uma senha válida';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: OutlinedButton.icon(
                    onPressed: controller.submitUser,
                    icon: const Icon(Icons.app_registration_rounded),
                    label: const Text('Cadastrar'),
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
