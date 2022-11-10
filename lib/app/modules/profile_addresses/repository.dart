import 'package:app_hortifruti/app/data/model/address.dart';
import 'package:app_hortifruti/app/data/provider/api.dart';

class ProfileAddressesRepository {
  final Api _api;

  ProfileAddressesRepository(this._api);

  Future<List<AddressModel>> getUserAddress() {
    return _api.getUserAddress();
  }

  Future<void> deleteUserAddress(int index) {
    return _api.deleteUserAddress(index);
  }
}
