import 'package:app_hortifruti/app/data/model/user.dart';
import 'package:app_hortifruti/app/data/provider/api.dart';

class RegistrationRepository {
  final Api _api;

  RegistrationRepository(this._api);

  Future<void> postUser(UserModel data) {
    return _api.postUser(data);
  }
}
