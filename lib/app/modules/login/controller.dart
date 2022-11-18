import 'package:app_hortifruti/app/core/utils/util_services.dart';
import 'package:app_hortifruti/app/data/model/login.dart';
import 'package:app_hortifruti/app/data/services/auth/service.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  void goToRegistration() async {
    isLoading.value = true;
    var login = await Get.toNamed(Routes.registration);

    if (login is LoginModel) {
      emailController.text = login.email;
      passwordController.text = login.password;
      Get.focusScope!.unfocus();
    }

    return;
  }

  void login() {
    isLoading.value = true;
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
        routeMessage: 'Ir para o menu inicial',
      );
    });
  }
}
