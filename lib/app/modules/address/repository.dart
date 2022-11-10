import 'package:app_hortifruti/app/data/model/address.dart';
import 'package:app_hortifruti/app/data/model/city.dart';
import 'package:app_hortifruti/app/data/provider/api.dart';

class AddressRepository {
  final Api _api;

  AddressRepository(this._api);

  Future<List<CityModel>> getCities() {
    return _api.getCities();
  }

  Future<void> postUserAddress(AddressModel data) async {
    await _api.postUserAddress(data);
  }

  Future<void> patchUserAddress(AddressModel data) async {
    await _api.patchUserAddress(data);
  }
}
