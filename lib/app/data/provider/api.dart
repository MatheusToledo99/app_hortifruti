import 'dart:convert';

import 'package:app_hortifruti/app/data/model/address.dart';
import 'package:app_hortifruti/app/data/model/city.dart';
import 'package:app_hortifruti/app/data/model/store.dart';
import 'package:app_hortifruti/app/data/model/token.dart';
import 'package:app_hortifruti/app/data/model/login.dart';
import 'package:app_hortifruti/app/data/model/user.dart';
import 'package:app_hortifruti/app/data/services/storage/service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {
  final _storageService = Get.find<StorageService>();

  @override
  void onInit() {
    httpClient.baseUrl = 'http://192.168.1.3:3333/';
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

  //Resgatar o usuário pelo token/fazer login
  Future<UserModel> getUser() async {
    var response = _errorHandler(await get('auth/me'));

    return UserModel.fromJson(response.body);
  }

  //Atualiza os dados de um usuário
  Future<UserModel> updateUser(UserModel data) async {
    var response = _errorHandler(await patch('cliente', jsonEncode(data)));

    return UserModel.fromJson(response.body);
  }

  //Resgatar os enderecos de um usuário
  Future<List<AddressModel>> getUserAddress() async {
    var response = _errorHandler(await get('enderecos'));

    print('resposta ${response.body}');

    List<AddressModel> data = [];
    for (var value in response.body) {
      data.add(AddressModel.fromJson(value));
    }

    return data;
  }

  //Resgatar as cidades que têm pelo menos um estabelecimento cadastrado
  Future<List<CityModel>> getCities() async {
    final response = _errorHandler(await get('cidades'));

    List<CityModel> data = [];
    for (var value in response.body) {
      data.add(CityModel.fromJson(value));
    }

    return data;
  }

  //Cadastrar um endereço para o usuário
  Future<void> postUserAddress(AddressModel data) async {
    _errorHandler(await post('enderecos', jsonEncode(data)));
  }

  //Buscar lista de estabecimentos
  Future<List<StoreModel>> getStores() async {
    final response = _errorHandler(await get('cidades/1/estabelecimentos'));

    List<StoreModel> data = [];
    for (var value in response.body) {
      data.add(StoreModel.fromJson(value));
    }
    return data;
  }

  //Recuperar dados de um estabelecimento
  Future<StoreModel> getStore(int index) async {
    final response = _errorHandler(await get('estabelecimento/$index'));

    return StoreModel.fromJson(response.body);
  }

  //Efetuar Login
  Future<TokenModel> login(LoginModel userData) async {
    final response = _errorHandler(await post('login', userData.toJson()));

    return TokenModel.fromJson(response.body);
  }

  //Enviar um pedido
  Future postOrder(order) async {
    _errorHandler(await post('pedidos', json.encode(order)));
  }

  Response<dynamic> _errorHandler(Response response) {
    print(response.bodyString);
    switch (response.statusCode) {
      case 200:
      case 202:
      case 204:
        return response;
      default:
        throw 'Um erro inesperado aconteceu, tente novamente!';
    }
  }
}
