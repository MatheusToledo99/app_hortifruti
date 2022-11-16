import 'package:app_hortifruti/app/core/utils/util_services.dart';
import 'package:app_hortifruti/app/data/model/address.dart';
import 'package:app_hortifruti/app/modules/profile_addresses/repository.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:get/get.dart';

class ProfileAddressesController extends GetxController
    with StateMixin<List<AddressModel>> {
  final ProfileAddressesRepository _repository;
  ProfileAddressesController(this._repository);
  final utilServices = UtilServices();

  @override
  void onInit() {
    fetchUserAddress();

    super.onInit();
  }

  void fetchUserAddress() {
    _repository.getUserAddress().then(
          (resp) => change(resp, status: RxStatus.success()),
          onError: (err) => change(null, status: RxStatus.error()),
        );
  }

  void goToNewAddress() async {
    await Get.toNamed(Routes.address);
    fetchUserAddress();
  }

  void goToEditAddress(AddressModel address) async {
    await Get.toNamed(Routes.address, arguments: address);
    fetchUserAddress();
  }

  void deleteUserAddress(AddressModel address) {
    _repository.deleteUserAddress(address.id!).then(
      (value) {
        fetchUserAddress();
        utilServices.messageSnackBar(
            message: 'O endereço foi excluído com sucesso');
      },
      onError: (error) {
        utilServices.messageSnackBar(
          message: 'Ocorreu um erro ao excluir o endereço',
          isError: true,
        );
      },
    );
  }
}
