import 'dart:convert';

import 'package:app_hortifruti/app/data/model/address.dart';
import 'package:app_hortifruti/app/data/model/city.dart';
import 'package:app_hortifruti/app/data/model/store.dart';
import 'package:app_hortifruti/app/data/model/token.dart';
import 'package:app_hortifruti/app/data/model/login.dart';
import 'package:app_hortifruti/app/data/model/user.dart';
import 'package:app_hortifruti/app/data/services/storage/service.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {
  final _storageService = Get.find<StorageService>();

  @override
  void onInit() {
    httpClient.baseUrl = 'http://192.168.1.73:3333/';
    // httpClient.baseUrl = 'https://38c6-2804-d45-8e95-1a00-95d9-add2-5e27-8622.ngrok.io/';

    httpClient.addRequestModifier((Request request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';

      return request;
    });

    httpClient.addAuthenticator((Request request) {
      final token = _storageService.token;

      final headers = {'Authorization': 'Bearer $token'};

      request.headers.addAll(headers);

      return request;
    });

    super.onInit();
  }

  Future<UserModel> getUser() async {
    var response = _errorHandler(await get('auth/me'));
    if (response.unauthorized) {
      await Get.toNamed(Routes.login);
      response = _errorHandler(await get('auth/me'));
    }

    return UserModel.fromJson(response.body);
  }

  Future<List<AddressModel>> getUserAddress() async {
    final response = _errorHandler(await get('enderecos'));

    List<AddressModel> data = [];
    for (var value in response.body) {
      data.add(AddressModel.fromJson(value));
    }

    return data;
  }

  Future<List<CityModel>> getCities() async {
    final response = _errorHandler(await get('cidades'));

    List<CityModel> data = [];
    for (var value in response.body) {
      data.add(CityModel.fromJson(value));
    }

    return data;
  }

  Future<void> postUserAddress(AddressModel data) async {
    _errorHandler(await post('enderecos', jsonEncode(data)));
  }

  Future<List<StoreModel>> getStores() async {
    final response = _errorHandler(await get('cidades/1/estabelecimentos'));

    List<StoreModel> data = [];
    for (var value in response.body) {
      data.add(StoreModel.fromJson(value));
    }
    return data;
  }

  Future<StoreModel> getStore(int index) async {
    final response = _errorHandler(await get('estabelecimento/$index'));

    return StoreModel.fromJson(response.body);
  }

  Future<TokenModel> login(LoginModel userData) async {
    final response = _errorHandler(await post('login', userData.toJson()));

    return TokenModel.fromJson(response.body);
  }

  Response<dynamic> _errorHandler(Response response) {
    print(response.body);
    switch (response.statusCode) {
      case 200:
      case 202:
      case 204:
      case 401:
        return response;
      default:
        throw 'Um erro inesperado aconteceu, tente novamente!';
    }
  }
}
