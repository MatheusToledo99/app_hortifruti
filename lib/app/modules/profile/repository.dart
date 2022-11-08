import 'package:app_hortifruti/app/data/model/user.dart';
import 'package:app_hortifruti/app/data/provider/api.dart';

class ProfileRepository {
  final Api _api;

  ProfileRepository(this._api);

  Future<UserModel> getUser() => _api.getUser();

  Future<UserModel> updateUser(UserModel data) => _api.updateUser(data);
}
