import 'dart:convert';

import 'package:app_hortifruti/app/data/model/address.dart';
import 'package:app_hortifruti/app/data/model/city.dart';
import 'package:app_hortifruti/app/data/model/order.dart';
import 'package:app_hortifruti/app/data/model/store.dart';
import 'package:app_hortifruti/app/data/model/token.dart';
import 'package:app_hortifruti/app/data/model/login.dart';
import 'package:app_hortifruti/app/data/model/user.dart';
import 'package:app_hortifruti/app/data/services/storage/service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {
  final _storageService = Get.find<StorageService>();

  //Iniciar a chamada à api, bem como acrescentar os headers e adicionar a autenticação;
  @override
  void onInit() {
    httpClient.baseUrl = 'https://api-hortifruti.herokuapp.com/';

    ///para rodar localhost - [http://192.168.1.7:3333/]

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

  //Atualizar os dados de um usuário (cliente)
  Future<UserModel> updateUser(UserModel data) async {
    var response = _errorHandler(await patch('cliente', jsonEncode(data)));

    return UserModel.fromJson(response.body);
  }

  //Cadastrar um novo usuário (cliente)
  Future<void> postUser(UserModel data) async {
    _errorHandler(await post('cliente/cadastro', data.toJson()));
  }

  //Resgatar os enderecos de um usuário
  Future<List<AddressModel>> getUserAddress() async {
    var response = _errorHandler(await get('enderecos'));

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

  //Resgatar os pedidosdo cliente
  Future<List<OrderModel>> getOrders() async {
    final response = _errorHandler(await get('pedidos'));

    List<OrderModel> data = [];
    for (var value in response.body) {
      data.add(OrderModel.fromJson(value));
    }

    return data;
  }

  //Resgatar um pedido específico do cliente
  Future<OrderModel> getOrder(String hashId) async {
    final response = _errorHandler(await get('pedidos/$hashId'));

    return OrderModel.fromJson(response.body);
  }

  //Cadastrar um endereço para o usuário (cliente)
  Future<void> postUserAddress(AddressModel data) async {
    _errorHandler(await post('enderecos', jsonEncode(data)));
  }

  //Atualizar um endereço para o usuário (cliente)
  Future<void> patchUserAddress(AddressModel data) async {
    _errorHandler(await patch('enderecos/${data.id}', data.toJson()));
  }

  //Deletar um endereço do usuário (cliente)
  Future<void> deleteUserAddress(int index) async {
    _errorHandler(await delete('enderecos/$index'));
  }

  //Buscar lista de estabecimentos na cidade selecionada
  Future<List<StoreModel>> getStores(int cityId) async {
    final response =
        _errorHandler(await get('cidades/$cityId/estabelecimentos'));

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
