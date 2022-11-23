import 'package:app_hortifruti/app/modules/login/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/background.jpg',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Login'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60),
            child: Form(
              key: controller.formKey,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            helperText:
                                'Exemplo: desenvolvimento@simplesoft.com.br'),
                        controller: controller.emailController,
                        validator: (String? email) {
                          if (email != null &&
                              !EmailValidator.validate(email)) {
                            return 'Favor digite seu email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        obscureText: controller.isVisible.value,
                        decoration: InputDecoration(
                          labelText: 'Senha:',
                          suffixIcon: IconButton(
                            onPressed: controller.changeVisible,
                            icon: Icon(
                              !controller.isVisible.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        controller: controller.passwordController,
                        validator: (String? password) {
                          if (password != null && password.isEmpty) {
                            return 'Favor digite sua senha';
                          }
                          return null;
                        },
                      ),
                    ),
                    if (!controller.isLoading.value) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: OutlinedButton.icon(
                          onPressed: controller.login,
                          icon: const Icon(Icons.login_sharp),
                          label: const Text('Entrar'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: OutlinedButton.icon(
                          onPressed: controller.goToRegistration,
                          icon: const Icon(Icons.app_registration_rounded),
                          label: const Text('Cadastrar'),
                        ),
                      ),
                    ] else
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
