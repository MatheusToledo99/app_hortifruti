import 'package:app_hortifruti/app/data/model/store.dart';
import 'package:app_hortifruti/app/data/provider/api.dart';

class StoreRepository {
  final Api _api;

  StoreRepository(this._api);

  Future<StoreModel> getStore(int id) {
    return _api.getStore(id);
  }
}
