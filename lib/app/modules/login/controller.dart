import 'package:app_hortifruti/app/core/utils/util_services.dart';
import 'package:app_hortifruti/app/data/model/login.dart';
import 'package:app_hortifruti/app/data/services/auth/service.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController =
      TextEditingController(text: 'cliente01@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');

  void login() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final userData = LoginModel(
      email: emailController.text,
      password: passwordController.text,
    );

    _authService.login(userData).then((value) {
      if (Get.routing.previous == Routes.checkout) {
        Get.back();
      } else {
        Get.offAllNamed(Routes.dashBoard, arguments: 1);
      }
    }, onError: (error) {
      UtilServices().showAlertDialog(
          message: 'Login não autorizado',
          route: Routes.dashBoard,
          routeMessage: 'Ir para o menu inicial');
    });
  }
}
