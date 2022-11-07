import 'package:app_hortifruti/app/data/model/store.dart';
import 'package:app_hortifruti/app/data/provider/api.dart';

class HomeRepository {
  final Api _api;

  HomeRepository(this._api);

  Future<List<StoreModel>> getStores() {
    return _api.getStores();
  }
}
