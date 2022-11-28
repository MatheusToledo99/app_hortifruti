import 'package:app_hortifruti/app/core/utils/util_services.dart';
import 'package:app_hortifruti/app/data/model/order.dart';
import 'package:app_hortifruti/app/modules/orders/repository.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController
    with StateMixin<List<OrderModel>> {
  final OrdersRepository _repository;
  OrdersController(this._repository);
  final utilServices = UtilServices();

  @override
  void onInit() async {
    getOrders();

    super.onInit();
  }

  void getOrders() async {
    _repository.getOrders().then((data) {
      if (data.isEmpty) {
        change(data, status: RxStatus.empty());
      } else {
        change(data, status: RxStatus.success());
      }
    }, onError: (error) {
      change(null, status: RxStatus.error());
    });
  }

  void goToBuySomething() {
    utilServices.showAlertDialog(
      message: ' 1° -  Selecione um estabelecimento.'
          '\n\n 2º -  Selecione a categoria do produto desejado.'
          '\n\n 3º -  Selecione o produto desejado.'
          '\n\n 4º -  Adicione quantidade e observação, se forem necessárias.'
          '\n\n 5º -  Adicione ao carrinho.'
          '\n\n 6º -  Refaça o processo (nº 2 ...) caso queira mais produtos no carrinho.'
          '\n\n 7º -  Quando finalizar sua compra, clique no ícone no canto inferiror direito.'
          '\n\n 8º -  Exclua produtos e adicione observação no pedido se necessário.'
          '\n\n 9º -  Clique em avançar.'
          '\n\n 10º - Selecione / Cadastre um endereço e escolha uma forma de pagamento.'
          '\n\n 11º - Clique em Enviar Pedido.',
      barrierDismissible: true,
      route: Routes.dashBoard,
      routeMessage: 'Prosseguir',
    );
  }
}
