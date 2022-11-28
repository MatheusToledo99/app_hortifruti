import 'package:app_hortifruti/app/core/utils/util_services.dart';
import 'package:app_hortifruti/app/data/model/user.dart';
import 'package:app_hortifruti/app/data/services/auth/service.dart';
import 'package:app_hortifruti/app/modules/profile/repository.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  final mask = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void onInit() {
    _repository.getUser().then(
      (resp) {
        nameController.text = resp.name;
        emailController.text = resp.email;
        phoneController.text = mask.maskText(resp.phone);
        change(resp, status: RxStatus.success());
      },
      onError: (err) {
        change(null, status: RxStatus.error('Erro ao recuperar seus dados'));
        super.onInit();
      },
    );
  }

  void logout() async {
    await _authService.logout();

    Get.offAllNamed(Routes.dashBoard);

    passwordController.text = '';
  }

  void submit() async {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) return;

    var userUpdate = UserModel(
      name: nameController.text,
      email: emailController.text,
      phone: mask.getUnmaskedText(),
      password: passwordController.text,
    );

    bool canUpdate = await utilServices.showDialogToChoose(
      message:
          'Você está atualizando seu cadastro, confirma todas informações?',
    );

    if (!canUpdate) {
      utilServices.messageSnackBar(
          message: 'Operação de atualização cancelada');
      return;
    }

    _repository.updateUser(userUpdate).then(
      (value) {
        utilServices.messageSnackBar(
            message: 'Seu cadastro foi atualizado com sucesso');
      },
      onError: (error) {
        utilServices.showAlertDialog(
          arguments: 1,
          message: 'Ocorreu um erro, tente novamente mais tarde',
          barrierDismissible: true,
        );
      },
    );
  }
}
