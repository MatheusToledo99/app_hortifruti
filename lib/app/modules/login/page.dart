import 'package:app_hortifruti/app/modules/login/controller.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
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
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Senha:'),
                  controller: controller.passwordController,
                  validator: (String? password) {
                    if (password != null && password.isEmpty) {
                      return 'Favor digite sua senha';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton.icon(
                  onPressed: controller.login,
                  icon: const Icon(Icons.login_sharp),
                  label: const Text('Entrar'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: OutlinedButton.icon(
                  onPressed: () => Get.toNamed(Routes.registration),
                  icon: const Icon(Icons.app_registration_rounded),
                  label: const Text('Cadastrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
