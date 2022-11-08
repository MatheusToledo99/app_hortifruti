import 'package:app_hortifruti/app/data/model/login.dart';
import 'package:app_hortifruti/app/data/model/user.dart';
import 'package:app_hortifruti/app/data/services/auth/repository.dart';
import 'package:app_hortifruti/app/data/services/storage/service.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final AuthRepository _repository;
  final _storageService = Get.find<StorageService>();
  final user = Rxn<UserModel>();
  bool get isLoggeed => user.value != null;

  AuthService(this._repository);

  @override
  void onInit() async {
    print(_storageService.token);

    if (_storageService.token != null) {
      await _getUser();
    }
    super.onInit();
  }

  Future<void> login(LoginModel userData) async {
    var userToken = await _repository.login(userData);

    await _storageService.saveToken(userToken.token);
    await _getUser();
  }

  Future _getUser() {
    return _repository.getUser().then((value) {
      user.value = value;
    });
  }
}
