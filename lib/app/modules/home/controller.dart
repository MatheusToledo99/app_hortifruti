import 'package:app_hortifruti/app/data/model/store.dart';
import 'package:get/get.dart';

import 'package:app_hortifruti/app/modules/home/repository.dart';

class HomeController extends GetxController with StateMixin<List<StoreModel>> {
  final HomeRepository _repository;

  HomeController(this._repository);

  @override
  void onInit() async {
    await atualizar();

    super.onInit();
  }

  Future atualizar() async {
    _repository.getStores().then(
      (data) {
        if (data.isEmpty) {
          change([], status: RxStatus.empty());
        } else {
          change(data, status: RxStatus.success());
        }
      },
      onError: (error) {
        change(null, status: RxStatus.error(error));
      },
    );
  }
}
