import 'package:app_hortifruti/app/data/model/store.dart';
import 'package:app_hortifruti/app/modules/store/repository.dart';
import 'package:get/get.dart';

class StoreController extends GetxController with StateMixin<StoreModel> {
  final StoreRepository _repository;
  StoreController(this._repository);

  RxBool visible = false.obs;

  @override
  void onInit() {
    int id = int.parse(Get.parameters['id']!);

    _repository.getStore(id).then(
      (data) {
        change(data, status: RxStatus.success());
      },
      onError: (error) {
        change(null, status: RxStatus.error(error));
      },
    );

    super.onInit();
  }

  bool visibility() {
    visible.value = !visible.value;
    return visible.value;
  }
}
