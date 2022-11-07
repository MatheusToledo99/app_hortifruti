import 'package:app_hortifruti/app/data/model/token.dart';
import 'package:app_hortifruti/app/data/model/login.dart';
import 'package:app_hortifruti/app/data/model/user.dart';
import 'package:app_hortifruti/app/data/provider/api.dart';

class AuthRepository {
  final Api _api;

  AuthRepository(this._api);

  Future<TokenModel> login(LoginModel userData) {
    return _api.login(userData);
  }

  Future<UserModel> getUser() => _api.getUser();
}
