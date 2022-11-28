import 'package:app_hortifruti/app/core/utils/util_services.dart';
import 'package:app_hortifruti/app/data/model/login.dart';
import 'package:app_hortifruti/app/data/services/auth/service.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();
  final formKey = GlobalKey<FormState>();
  final utilServices = UtilServices();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;

  void changeVisible() => isVisible.value = !isVisible.value;

  void goToRegistration() async {
    isLoading.value = true;

    var login = await Get.toNamed(Routes.registration);

    isLoading.value = false;
    if (login is LoginModel) {
      emailController.text = login.email;
      passwordController.text = login.password;
      Get.focusScope!.unfocus();
    }

    return;
  }

  void login() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading.value = true;

    final userData = LoginModel(
      email: emailController.text,
      password: passwordController.text,
    );

    _authService.login(userData).then((value) {
      Get.offAllNamed(Routes.dashBoard, arguments: 1);
    }, onError: (error) {
      utilServices.messageSnackBar(
        message: 'Email e/ou Senha inválidos.'
            '\nTente novamente mais tarde.',
        isError: true,
        duration: 2,
      );
      isLoading.value = false;
    });
  }
}
