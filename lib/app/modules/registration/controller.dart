import 'package:app_hortifruti/app/core/utils/util_services.dart';
import 'package:app_hortifruti/app/data/model/login.dart';
import 'package:app_hortifruti/app/data/model/user.dart';
import 'package:app_hortifruti/app/modules/registration/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegistrationController extends GetxController {
  final RegistrationRepository _repository;
  RegistrationController(this._repository);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final mask = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final isNotVisible = true.obs;

  void changeVisible() => isNotVisible.value = !isNotVisible.value;

  void submitUser() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    UserModel newUser = UserModel(
      name: nameController.text,
      email: emailController.text,
      phone: mask.getUnmaskedText(),
      password: passwordController.text,
    );

    _repository.postUser(newUser).then(
      (value) {
        UtilServices()
            .messageSnackBar(message: 'Cadastro realizado com sucesso');

        var login = LoginModel(
          email: emailController.text,
          password: passwordController.text,
        );

        Get.back(result: login);
      },
    );
  }
}
