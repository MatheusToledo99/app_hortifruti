import 'package:app_hortifruti/app/data/model/city.dart';
import 'package:app_hortifruti/app/data/provider/api.dart';

class CitiesRepository {
  final Api _api;

  CitiesRepository(this._api);

  Future<List<CityModel>> getCities() {
    return _api.getCities();
  }
}
