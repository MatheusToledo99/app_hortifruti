import 'package:app_hortifruti/app/core/utils/util_services.dart';
import 'package:app_hortifruti/app/data/model/user.dart';
import 'package:app_hortifruti/app/data/services/auth/service.dart';
import 'package:app_hortifruti/app/modules/profile/repository.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController with StateMixin<UserModel> {
  final ProfileRepository _repository;

  ProfileController(this._repository);

  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  final _authService = Get.find<AuthService>();
  bool get isLoggeed => _authService.isLoggeed;
  final utilServices = UtilServices();

  @override
  void onInit() {
    _repository.getUser().then((resp) {
      nameController.text = resp.name;
      emailController.text = resp.email;
      phoneController.text = resp.phone;

      change(resp, status: RxStatus.success());
    }, onError: (err) {
      print(err);
      change(
        null,
        status: RxStatus.error('Error get data'),
      );
      super.onInit();
    });
  }

  void logout() async {
    await _authService.logout();

    Get.offAllNamed(Routes.dashBoard);

    passwordController.text = '';
  }

  void submit() {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) return;

    var userUpdate = UserModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      password: passwordController.text,
    );

    _repository.updateUser(userUpdate).then(
      (value) {
        utilServices.messageSnackBar(
            message: 'Seu cadastro foi atualizado com sucesso');
      },
      onError: (error) {
        utilServices.showAlertDialog(
          message: 'Ocorreu um erro, tente novamente mais tarde',
          barrierDismissible: true,
        );
      },
    );
  }
}
